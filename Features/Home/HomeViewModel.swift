//
//  HomeViewModel.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 30.01.2026.
//

import Foundation

@MainActor
final class HomeViewModel: HomeViewModelProtocol {

    let didChange = ObservableBox<Void>()

    private(set) var viewState: ViewState = .idle {
        didSet {
            invalidate()
        }
    }
    private(set) var nowPlayingMovies: [MovieListModel] = [] {
        didSet {
            invalidate()
        }
    }
    private(set) var upcomingMovies: [MovieListModel] = [] {
        didSet {
            invalidate()
        }
    }
    private(set) var searchResults: [MovieListModel] = [] {
        didSet {
            invalidate()
        }
    }
    var queryString: String = "" {
        didSet {
            if queryString.isEmpty {
                searchResults.removeAll()
                invalidate()
                return
            }
            scheduleSearch(for: queryString)
            invalidate()
        }
    }
    private let dataController: HomeDataProtocol
    private let networkScheduler: NetworkSchedulerProtocol
    private var currentPage = 1
    private var totalPages = 1
    private var searchTask: Task<Void, Never>?
    private let minimumSearchLength = 2
    private let searchDebounceNanoseconds: UInt64 = 350_000_000
    private var isLoadingMore = false
    private var isBatching = false
    private var needsInvalidate = false
    private let onNavigateToMovieDetail: (_ movieId: Int, _ title: String) -> Void

    init(dataController: HomeDataProtocol,
         networkScheduler: NetworkSchedulerProtocol,
         onNavigateToMovieDetail: @escaping (_ movieId: Int, _ title: String) -> Void) {
        self.dataController = dataController
        self.networkScheduler = networkScheduler
        self.onNavigateToMovieDetail = onNavigateToMovieDetail
    }

    func onAppear() {
        viewState = .loading
        invalidate()
        Task {
            await loadInitialMovies()
        }
    }

    func onDisappear() {
        searchTask?.cancel()
        didChange.removeAll()
        Task { @MainActor in
            await networkScheduler.killAllTasks()
        }
    }

    func refresh() {
        currentPage = 1
        onAppear()
    }

    func loadMoreMovies() async {
        guard !isLoadingMore else {
            return
        }
        isLoadingMore = true
        defer {
            isLoadingMore = false
        }
        let nextPage = currentPage + 1
        guard nextPage <= totalPages else {
            await MainActor.run {
                let message = "End of the list..."
                viewState = .error(message: message)
            }
            return
        }

        currentPage = nextPage
        do {
            try await networkScheduler.doQueue { [weak self] in
                guard let self else {
                    return
                }

                let response = try await self.dataController.fetchUpcomingList(self.currentPage)
                await MainActor.run {
                    self.batch {
                        self.viewState = .loaded
                        self.upcomingMovies.append(contentsOf: response?.results ?? [])
                    }
                }
            }
        } catch {
            await MainActor.run {
                self.batch {
                    let message = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
                    viewState = .error(message: message)
                }
            }
        }
    }

    func routeToMovieDetail(_ movie: MovieListModel) {
        onNavigateToMovieDetail(movie.id ?? .zero,
                                movie.title ?? "")
    }

    private func loadInitialMovies() async {
        do {
            try await networkScheduler.doQueue { [weak self] in
                guard let self else {
                    return
                }

                async let nowPlaying = self.dataController.fetchNowPlayingList()
                async let upcoming = self.dataController.fetchUpcomingList(currentPage)
                let (now, up) = try await (nowPlaying, upcoming)
                await MainActor.run {
                    self.batch {
                        self.nowPlayingMovies = now?.results ?? []
                        self.upcomingMovies = up?.results ?? []
                        self.totalPages = up?.total_pages ?? 1
                        self.viewState = .loaded
                    }
                }
            }
        } catch {
            await MainActor.run {
                self.batch {
                    let message = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
                    viewState = .error(message: message)
                }
            }
        }
    }

    private func scheduleSearch(for query: String) {
        searchTask?.cancel()
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.count >= minimumSearchLength else {
            searchResults = []
            return
        }

        searchTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: self?.searchDebounceNanoseconds ?? 0)
            guard !Task.isCancelled else {
                return
            }
            await self?.performSearch(query: trimmed)
        }
    }

    private func performSearch(query: String) async {
        do {
            try await networkScheduler.doQueue { [weak self] in
                guard let self else {
                    return
                }

                let response = try await self.dataController.searchInMovies(query, currentPage)
                await MainActor.run {
                    self.batch {
                        self.searchResults = (response?.results ?? []).filter {
                            $0.backdrop_path != nil
                        }
                    }
                }
            }
        } catch {
            await MainActor.run {
                self.batch {
                    self.searchResults = []
                }
            }
            #if DEBUG
            print("Search failed: \(error)")
            #endif
        }
    }

    private func invalidate() {
        if isBatching {
            needsInvalidate = true
            return
        }
        didChange.emit(())
    }

    private func batch(_ updates: () -> Void) {
        isBatching = true
        needsInvalidate = true
        updates()
        isBatching = false
        if needsInvalidate {
            needsInvalidate = false
            didChange.emit(())
        }
    }
}

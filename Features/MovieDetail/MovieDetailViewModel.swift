//
//  MovieDetailViewModel.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 31.01.2026.
//
import Foundation
import Observation

@MainActor
@Observable
final class MovieDetailViewModel: MovieDetailViewModelProtocol {

    private(set) var viewState: ViewState = .idle
    private(set) var movieDetail: MovieDetailModel?
    private(set) var similarMovies: [SimilarMoviesListModel] = []
    private let dataController: MovieDetailDataProtocol
    private let movieId: Int
    private var currentPage = 1
    private var totalPages = 1

    init(dataController: MovieDetailDataProtocol,
         movieId: Int) {
        self.dataController = dataController
        self.movieId = movieId
    }

    func onAppear() {
        viewState = .loading
        Task {
            await loadInitialData()
        }
    }

    func onDisappear() {
        Task { @MainActor in
            await NetworkScheduler.shared.killAllTasks()
        }
    }

    private func loadInitialData() async {
        do {
            try await NetworkScheduler.shared.doQueue { [weak self] in
                guard let self else {
                    return
                }

                async let movieDetail = self.dataController.fetchMovieDetail(movieId)
                async let similarMovies = self.dataController.fetchSimilarMovies(movieId, currentPage)
                let (detail, similar) = try await (movieDetail, similarMovies)
                await MainActor.run {
                    self.viewState = .loaded
                    guard let detail, let similar else {
                        return
                    }

                    self.movieDetail = detail
                    self.similarMovies = similar.results ?? []
                    self.totalPages = similar.total_pages ?? 1
                }
            }
        } catch {
            await MainActor.run {
                let message = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
                viewState = .error(message: message)
            }
        }
    }
}

//
//  HomeViewModelTests.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 30.01.2026.
//

import Foundation
import XCTest

@testable import MovieProjectConcurrency

@MainActor
final class HomeViewModelTests: XCTestCase {

    private var sut: HomeViewModel!
    private var dataController: MockHomeDataController!
    private var navigationSpy: NavigationSpy!

    override func setUp() {
        super.setUp()
        dataController = MockHomeDataController()
        navigationSpy = NavigationSpy()
        sut = HomeViewModel(
            dataController: dataController,
            onNavigateToMovieDetail: navigationSpy.navigate(movieId:title:)
        )
    }

    override func tearDown() {
        sut = nil
        dataController = nil
        navigationSpy = nil
        super.tearDown()
    }

    func test_initialState_isIdleAndEmpty() {
        XCTAssertEqual(sut.viewState, .idle)
        XCTAssertTrue(sut.nowPlayingMovies.isEmpty)
        XCTAssertTrue(sut.upcomingMovies.isEmpty)
        XCTAssertTrue(sut.searchResults.isEmpty)
        XCTAssertEqual(sut.queryString, "")
    }

    func test_onAppear_loadsMoviesAndUpdatesState() async {
        guard let first = makeMovieListModel(id: 1, title: "Now", backdropPath: "/now"),
              let second = makeMovieListModel(id: 2, title: "Up", backdropPath: "/up") else {
            return XCTFail("Failed to create test movies")
        }

        let nowPlaying = [first]
        let upcoming = [second]
        dataController.fetchNowPlayingListResult = .success(
            MovieModel(results: nowPlaying, total_pages: 1)
        )
        dataController.fetchUpcomingListResultsQueue = [
            .success(MovieModel(results: upcoming, total_pages: 3))
        ]

        sut.onAppear()
        await waitForViewState(.loaded)

        XCTAssertEqual(dataController.fetchNowPlayingListCallCount, 1)
        XCTAssertEqual(dataController.fetchUpcomingListCallCount, 1)
        XCTAssertEqual(dataController.fetchUpcomingListPage, 1)
        XCTAssertEqual(sut.nowPlayingMovies, nowPlaying)
        XCTAssertEqual(sut.upcomingMovies, upcoming)
        XCTAssertEqual(sut.viewState, .loaded)
    }

    func test_onAppear_setsErrorStateOnFailure() async {
        dataController.fetchNowPlayingListResult = .failure(TestError(message: "Boom"))
        dataController.fetchUpcomingListResultsQueue = [
            .success(MovieModel(results: [], total_pages: 1))
        ]

        sut.onAppear()
        await waitForViewState(.error(message: "Boom"))

        XCTAssertEqual(sut.viewState, .error(message: "Boom"))
    }

    func test_loadMoreMovies_appendsNextPageResults() async {
        guard let first = makeMovieListModel(id: 1, title: "First", backdropPath: "/1"),
              let second = makeMovieListModel(id: 2, title: "Second", backdropPath: "/2") else {
            return XCTFail("Failed to create test movies")
        }

        let initialUpcoming = [first]
        let nextUpcoming = [second]
        dataController.fetchNowPlayingListResult = .success(
            MovieModel(results: [], total_pages: 1)
        )
        dataController.fetchUpcomingListResultsQueue = [
            .success(MovieModel(results: initialUpcoming, total_pages: 2)),
            .success(MovieModel(results: nextUpcoming, total_pages: 2))
        ]

        sut.onAppear()
        await waitForViewState(.loaded)

        await sut.loadMoreMovies()

        XCTAssertEqual(dataController.fetchUpcomingListCallCount, 2)
        XCTAssertEqual(dataController.fetchUpcomingListPage, 2)
        XCTAssertEqual(sut.upcomingMovies, initialUpcoming + nextUpcoming)
        XCTAssertEqual(sut.viewState, .loaded)
    }

    func test_loadMoreMovies_setsErrorWhenEndOfList() async {
        dataController.fetchNowPlayingListResult = .success(
            MovieModel(results: [], total_pages: 1)
        )
        dataController.fetchUpcomingListResultsQueue = [
            .success(MovieModel(results: [], total_pages: 1))
        ]

        sut.onAppear()
        await waitForViewState(.loaded)

        await sut.loadMoreMovies()

        XCTAssertEqual(dataController.fetchUpcomingListCallCount, 1)
        XCTAssertEqual(sut.viewState, .error(message: "End of the list..."))
    }

    func test_queryString_shortQueryClearsResultsAndSkipsSearch() async {
        guard let first = makeMovieListModel(id: 1, title: "Star", backdropPath: "/s") else {
            return XCTFail("Failed to create test movie")
        }

        let results = [first]
        dataController.searchInMoviesResult = .success(
            SearchModel(page: 1, total_pages: 1, results: results)
        )

        sut.queryString = "Star"
        await waitForSearchResultsCount(1)
        let callCount = dataController.searchInMoviesCallCount

        sut.queryString = "a"
        await waitForSearchResultsCount(0)

        XCTAssertEqual(dataController.searchInMoviesCallCount, callCount)
        XCTAssertTrue(sut.searchResults.isEmpty)
    }

    func test_queryString_trimsAndFiltersSearchResults() async {
        guard let withBackdrop = makeMovieListModel(id: 1, title: "Keep", backdropPath: "/ok"),
              let withoutBackdrop = makeMovieListModel(id: 2, title: "Drop", backdropPath: nil) else {
            return XCTFail("Failed to create test movies")
        }

        dataController.searchInMoviesResult = .success(
            SearchModel(page: 1, total_pages: 1, results: [withBackdrop, withoutBackdrop])
        )

        sut.queryString = "  Matrix  "
        await waitForSearchResultsCount(1)

        XCTAssertEqual(dataController.searchInMoviesQuery, "Matrix")
        XCTAssertEqual(sut.searchResults, [withBackdrop])
    }

    func test_routeToMovieDetail_usesDefaultsForNilValues() {
        guard let movie = makeMovieListModel(id: nil, title: nil, backdropPath: "/img") else {
            return XCTFail("Failed to create test movie")
        }

        sut.routeToMovieDetail(movie)

        XCTAssertEqual(navigationSpy.navigateCallCount, 1)
        XCTAssertEqual(navigationSpy.lastMovieId, 0)
        XCTAssertEqual(navigationSpy.lastTitle, "")
    }

    private func makeMovieListModel(id: Int?,
                                    title: String?,
                                    backdropPath: String?) -> MovieListModel? {
        var json: [String: Any] = [
            "vote_average": 7.5,
            "overview": "Overview",
            "release_date": "2024-01-01"
        ]
        json["id"] = id ?? NSNull()
        json["title"] = title ?? NSNull()
        json["backdrop_path"] = backdropPath ?? NSNull()

        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            return try JSONDecoder().decode(MovieListModel.self, from: data)
        } catch {
            XCTFail("Failed to build MovieListModel from JSON: \(error)")
            return nil
        }
    }

    private func waitForViewState(_ expected: ViewState,
                                  timeout: TimeInterval = 1.0,
                                  file: StaticString = #filePath,
                                  line: UInt = #line) async {
        let deadline = Date().addingTimeInterval(timeout)
        while Date() < deadline {
            if sut.viewState == expected {
                return
            }
            try? await Task.sleep(nanoseconds: 50_000_000)
        }
        XCTFail("Expected viewState to become \(expected)", file: file, line: line)
    }

    private func waitForSearchResultsCount(_ count: Int,
                                           timeout: TimeInterval = 1.0,
                                           file: StaticString = #filePath,
                                           line: UInt = #line) async {
        let deadline = Date().addingTimeInterval(timeout)
        while Date() < deadline {
            if sut.searchResults.count == count {
                return
            }
            try? await Task.sleep(nanoseconds: 50_000_000)
        }
        XCTFail("Expected searchResults count \(count)", file: file, line: line)
    }
}

// MARK: - Test Doubles

private final class MockHomeDataController: HomeDataProtocol {

    var fetchNowPlayingListCallCount = 0
    var fetchNowPlayingListResult: Result<MovieModel?, Error> = .success(nil)

    var fetchUpcomingListCallCount = 0
    var fetchUpcomingListPage: Int?
    var fetchUpcomingListResult: Result<MovieModel?, Error> = .success(nil)
    var fetchUpcomingListResultsQueue: [Result<MovieModel?, Error>] = []

    var searchInMoviesCallCount = 0
    var searchInMoviesQuery: String?
    var searchInMoviesPage: Int?
    var searchInMoviesResult: Result<SearchModel?, Error> = .success(nil)

    func fetchNowPlayingList() async throws -> MovieModel? {
        fetchNowPlayingListCallCount += 1
        return try fetchNowPlayingListResult.get()
    }

    func fetchUpcomingList(_ currentPage: Int) async throws -> MovieModel? {
        fetchUpcomingListCallCount += 1
        fetchUpcomingListPage = currentPage
        if !fetchUpcomingListResultsQueue.isEmpty {
            return try fetchUpcomingListResultsQueue.removeFirst().get()
        }
        return try fetchUpcomingListResult.get()
    }

    func searchInMovies(_ query: String, _ currentPage: Int) async throws -> SearchModel? {
        searchInMoviesCallCount += 1
        searchInMoviesQuery = query
        searchInMoviesPage = currentPage
        return try searchInMoviesResult.get()
    }
}

private final class NavigationSpy {

    private(set) var navigateCallCount = 0
    private(set) var lastMovieId: Int?
    private(set) var lastTitle: String?

    func navigate(movieId: Int, title: String) {
        navigateCallCount += 1
        lastMovieId = movieId
        lastTitle = title
    }
}

private struct TestError: LocalizedError {

    let message: String
    var errorDescription: String? {
        message
    }
}

//
//  MovieDetailViewModelTests.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 31.01.2026.
//
import Foundation
import XCTest

@testable import MovieProjectConcurrency

@MainActor
final class MovieDetailViewModelTests: XCTestCase {

    private var sut: MovieDetailViewModel!
    private var dataController: MockMovieDetailDataController!

    override func setUp() {
        super.setUp()
        dataController = MockMovieDetailDataController()
        sut = MovieDetailViewModel(dataController: dataController, movieId: 42)
    }

    override func tearDown() {
        sut = nil
        dataController = nil
        super.tearDown()
    }

    func test_initialState_isIdleAndEmpty() {
        XCTAssertEqual(sut.viewState, .idle)
        XCTAssertNil(sut.movieDetail)
        XCTAssertTrue(sut.similarMovies.isEmpty)
    }

    func test_onAppear_loadsDetailAndSimilarMovies() async {
        guard let detail = makeMovieDetailModel(id: 42, title: "Matrix"),
              let similar = makeSimilarMovieListModel(id: 7, title: "Reloaded", backdropPath: "/back") else {
            return XCTFail("Failed to create test data")
        }

        dataController.fetchMovieDetailResult = .success(detail)
        dataController.fetchSimilarMoviesResult = .success(
            SimilarMoviesModel(page: 1, total_pages: 2, results: [similar])
        )

        sut.onAppear()
        await waitForViewState(.loaded)

        XCTAssertEqual(dataController.fetchMovieDetailCallCount, 1)
        XCTAssertEqual(dataController.fetchMovieDetailMovieId, 42)
        XCTAssertEqual(dataController.fetchSimilarMoviesCallCount, 1)
        XCTAssertEqual(dataController.fetchSimilarMoviesMovieId, 42)
        XCTAssertEqual(dataController.fetchSimilarMoviesPage, 1)
        XCTAssertEqual(sut.movieDetail?.id, 42)
        XCTAssertEqual(sut.movieDetail?.title, "Matrix")
        XCTAssertEqual(sut.similarMovies.count, 1)
        XCTAssertEqual(sut.similarMovies.first?.id, 7)
        XCTAssertEqual(sut.similarMovies.first?.title, "Reloaded")
    }

    func test_onAppear_setsLoadedWhenResponsesAreNil() async {
        dataController.fetchMovieDetailResult = .success(nil)
        dataController.fetchSimilarMoviesResult = .success(nil)

        sut.onAppear()
        await waitForViewState(.loaded)

        XCTAssertNil(sut.movieDetail)
        XCTAssertTrue(sut.similarMovies.isEmpty)
    }

    func test_onAppear_setsErrorOnFailure() async {
        dataController.fetchMovieDetailResult = .failure(TestError(message: "Network"))
        dataController.fetchSimilarMoviesResult = .success(nil)

        sut.onAppear()
        await waitForViewState(.error(message: "Network"))

        XCTAssertEqual(sut.viewState, .error(message: "Network"))
    }

    private func makeMovieDetailModel(id: Int?,
                                      title: String?) -> MovieDetailModel? {
        let json: [String: Any] = [
            "id": id ?? NSNull(),
            "backdrop_path": "/detail",
            "title": title ?? NSNull(),
            "overview": "Overview",
            "vote_average": 8.2,
            "imdb_id": "tt1234567",
            "release_date": "2024-01-01"
        ]

        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            return try JSONDecoder().decode(MovieDetailModel.self, from: data)
        } catch {
            XCTFail("Failed to build MovieListModel from JSON: \(error)")
            return nil
        }
    }

    private func makeSimilarMovieListModel(id: Int?,
                                           title: String?,
                                           backdropPath: String?) -> SimilarMoviesListModel? {
        let json: [String: Any] = [
            "id": id ?? NSNull(),
            "backdrop_path": backdropPath ?? NSNull(),
            "title": title ?? NSNull(),
            "release_date": "2024-01-02"
        ]

        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            return try JSONDecoder().decode(SimilarMoviesListModel.self, from: data)
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
}

// MARK: - Test Doubles

private final class MockMovieDetailDataController: MovieDetailDataProtocol {

    var fetchMovieDetailCallCount = 0
    var fetchMovieDetailMovieId: Int?
    var fetchMovieDetailResult: Result<MovieDetailModel?, Error> = .success(nil)

    var fetchSimilarMoviesCallCount = 0
    var fetchSimilarMoviesMovieId: Int?
    var fetchSimilarMoviesPage: Int?
    var fetchSimilarMoviesResult: Result<SimilarMoviesModel?, Error> = .success(nil)

    func fetchMovieDetail(_ movieId: Int) async throws -> MovieDetailModel? {
        fetchMovieDetailCallCount += 1
        fetchMovieDetailMovieId = movieId
        return try fetchMovieDetailResult.get()
    }

    func fetchSimilarMovies(_ movieId: Int, _ currentPage: Int) async throws -> SimilarMoviesModel? {
        fetchSimilarMoviesCallCount += 1
        fetchSimilarMoviesMovieId = movieId
        fetchSimilarMoviesPage = currentPage
        return try fetchSimilarMoviesResult.get()
    }
}

private struct TestError: LocalizedError {

    let message: String
    var errorDescription: String? {
        message
    }
}

//
//  MovieDetailDataController.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 31.01.2026.
//

final class MovieDetailDataController: MovieDetailDataProtocol {

    private let apiService: ServiceLayer

    init(apiService: ServiceLayer) {
        self.apiService = apiService
    }

    func fetchMovieDetail(_ movieId: Int) async throws -> MovieDetailModel? {
        let request = GetMovieDetailRequest(movieId: movieId)
        return try await apiService.send(request: request)
    }

    func fetchSimilarMovies(_ movieId: Int, _ currentPage: Int) async throws -> SimilarMoviesModel? {
        let request = GetSimilarMoviesRequest(movieId: movieId, page: currentPage)
        return try await apiService.send(request: request)
    }
}

//
//  MovieDetailDataProtocol.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 31.01.2026.
//

protocol MovieDetailDataProtocol {

    /// Fetches detail of movie
    ///
    /// - Returns: Details of movie which has given id
    func fetchMovieDetail(_ movieId: Int) async throws -> MovieDetailModel?

    /// Fetches similar movie list
    ///
    /// - Parameters:
    ///  - movieId: Id for searching similarity
    ///  - currentPage: Page number for pagination
    /// - Returns: Movie list of table
    func fetchSimilarMovies(_ movieId: Int, _ currentPage: Int) async throws -> SimilarMoviesModel?
}

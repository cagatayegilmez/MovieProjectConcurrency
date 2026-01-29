//
//  GetSimilarMoviesRequest.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 29.01.2026.
//

import Foundation

struct GetSimilarMoviesRequest: APIRequest {

    typealias Response = SimilarMoviesModel

    var headers: [String: String]?
    var baseUrl: URL = Environment.rootURL
    let method: HTTPMethodType = .get
    var path: String {
        "movie/\(movieId)/similar"
    }
    var queryParameters: [URLQueryItem] {
        [
            URLQueryItem(name: "api_key", value: Environment.apiKey),
            URLQueryItem(name: "page", value: "\(page)")
        ]
    }
    let movieId: Int
    let page: Int

    init(movieId: Int, page: Int) {
        self.movieId = movieId
        self.page = page
    }
}

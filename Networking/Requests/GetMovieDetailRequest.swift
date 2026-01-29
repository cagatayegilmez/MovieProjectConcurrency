//
//  GetMovieDetailRequest.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 29.01.2026.
//

import Foundation

struct GetMovieDetailRequest: APIRequest {

    typealias Response = MovieDetailModel

    var headers: [String: String]?
    var baseUrl: URL = Environment.rootURL
    let method: HTTPMethodType = .get
    var path: String {
        "movie/\(movieId)"
    }
    var queryParameters: [URLQueryItem] {
        [URLQueryItem(name: "api_key", value: Environment.apiKey)]
    }
    let movieId: Int

    init(movieId: Int) {
        self.movieId = movieId
    }
}

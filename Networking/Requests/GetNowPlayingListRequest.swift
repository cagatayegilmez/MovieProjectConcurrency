//
//  GetNowPlayingListRequest.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 29.01.2026.
//

import Foundation

struct GetNowPlayingListRequest: APIRequest {

    typealias Response = MovieModel

    var headers: [String: String]?
    var baseUrl: URL = Environment.rootURL
    let method: HTTPMethodType = .get
    var path: String {
        "movie/now_playing"
    }
    var queryParameters: [URLQueryItem] {
        [URLQueryItem(name: "api_key", value: Environment.apiKey)]
    }
}

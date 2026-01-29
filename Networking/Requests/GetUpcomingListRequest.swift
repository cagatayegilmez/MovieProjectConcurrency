//
//  GetUpcomingListRequest.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 29.01.2026.
//

import Foundation

struct GetUpcomingListRequest: APIRequest {

    typealias Response = MovieModel

    var headers: [String: String]?
    var baseUrl: URL = Environment.rootURL
    let method: HTTPMethodType = .get
    var path: String {
        "movie/upcoming"
    }
    var queryParameters: [URLQueryItem] {
        [
            URLQueryItem(name: "api_key", value: Environment.apiKey),
            URLQueryItem(name: "page", value: "\(page)")
        ]
    }
    let page: Int

    init(page: Int) {
        self.page = page
    }
}

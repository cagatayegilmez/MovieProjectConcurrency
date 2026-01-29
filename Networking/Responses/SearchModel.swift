//
//  SearchModel.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 29.01.2026.
//

import Foundation

struct SearchModel: Decodable {

    let page: Int?
    let total_pages: Int?
    let results: [MovieListModel]?
}

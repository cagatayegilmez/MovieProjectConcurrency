//
//  ViewState.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 30.01.2026.
//

enum ViewState: Equatable {

    case idle
    case loading
    case loaded
    case error(message: String)
}

//
//  DefaultAppScreenFactory.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 29.01.2026.
//

import UIKit

final class DefaultAppScreenFactory: AppScreenFactory {

    var navigate: ((AppRoute) -> Void)?

    func makeMovieList() -> UIViewController {
        // - TODO: Make home view
        UIViewController()
    }

    func makeMovieDetail(movieId: Int, movieTitle: String) -> UIViewController {
        // - TODO: Make detail view
        UIViewController()
    }
}

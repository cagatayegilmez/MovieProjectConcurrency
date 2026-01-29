//
//  BaseCoordinator.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 29.01.2026.
//

import UIKit

protocol Coordinator: AnyObject {

    /// An array of child coordinators
    var childCoordinators: [Coordinator] { get set }

    /// Function of coordinator start
    func start()
}

protocol NavigationCoordinator: Coordinator {

    /// UIKit navigation element
    var navigationController: UINavigationController { get }
}

enum AppRoute: Equatable {

    /// Main screen, movie list.
    case movieList

    /// Movie detail screen
    ///
    ///  - Parameters:
    ///   - movieId: Int id of movie for fetching details
    ///   - title: String title of movie for informing on navigation bar
    case movieDetail(movieId: Int, title: String)
}

enum NavigationBarStyle: Equatable {

    /// Visible navigation bar style
    case visible

    /// Invisible navigation bar style
    case hidden
}

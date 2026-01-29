//
//  AppCoordinator.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 29.01.2026.
//

import UIKit

protocol AppScreenFactory {

    func makeMovieList() -> UIViewController
    func makeMovieDetail(movieId: Int, movieTitle: String) -> UIViewController
}

final class AppCoordinator: NSObject {
    var childCoordinators: [Coordinator] = []

    let navigationController: UINavigationController
    private let factory: AppScreenFactory
    private let navBarStyle: (AppRoute) -> NavigationBarStyle

    init(
        navigationController: UINavigationController = UINavigationController(),
        factory: AppScreenFactory,
        navBarStyle: @escaping (AppRoute) -> NavigationBarStyle = { _ in .visible }
    ) {
        self.navigationController = navigationController
        self.factory = factory
        self.navBarStyle = navBarStyle
        super.init()
        self.navigationController.delegate = self
    }

    func start() {
        show(route: .movieList, animated: false)
    }

    func show(route: AppRoute, animated: Bool = true) {
        let vc = makeViewController(for: route)
        applyNavigationBarStyle(for: route, animated: animated)

        switch route {
        case .movieList:
            navigationController.setViewControllers([vc], animated: animated)
        case .movieDetail:
            navigationController.pushViewController(vc, animated: animated)
        }
    }

    // MARK: - Private

    private func makeViewController(for route: AppRoute) -> UIViewController {
        switch route {
        case .movieList:
            return factory.makeMovieList().tagged(route)
        case .movieDetail(let movieId, let title):
            return factory.makeMovieDetail(movieId: movieId,
                                           movieTitle: title)
            .tagged(route)
        }
    }

    private func applyNavigationBarStyle(for route: AppRoute, animated: Bool) {
        let hidden: Bool
        switch navBarStyle(route) {
        case .visible:
            hidden = false
        case .hidden:
            hidden = true
        }
        navigationController.setNavigationBarHidden(hidden, animated: animated)
    }
}

// MARK: - UINavigationControllerDelegate

extension AppCoordinator: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController,
        animated: Bool
    ) {
        guard let route = viewController.appRoute else {
            return
        }

        applyNavigationBarStyle(for: route, animated: animated)
    }
}

// MARK: - Route tagging (same file, once)

private var appRouteKey: UInt8 = 0

private extension UIViewController {
    var appRoute: AppRoute? {
        get {
            objc_getAssociatedObject(self, &appRouteKey) as? AppRoute
        }
        set {
            objc_setAssociatedObject(self, &appRouteKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /// fluent: vc.tagged(.movieList)
    func tagged(_ route: AppRoute) -> UIViewController {
        self.appRoute = route
        return self
    }
}

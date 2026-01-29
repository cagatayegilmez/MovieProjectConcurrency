//
//  SceneDelegate.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 28.01.2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        let window = UIWindow(windowScene: windowScene)
        let factory = DefaultAppScreenFactory()
        let navController = UINavigationController()
        let coordinator = AppCoordinator(navigationController: navController,
                                         factory: factory) { route in
            switch route {
            case .movieList:
                return .hidden
            case .movieDetail:
                return .visible
            }
        }
        factory.navigate = { [weak coordinator] route in
            coordinator?.show(route: route)
        }
        self.appCoordinator = coordinator

        window.rootViewController = coordinator.navigationController
        window.makeKeyAndVisible()
        self.window = window

        coordinator.start()
    }
}

//
//  NavigationController.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 18.04.2026.
//

import Foundation
import UIKit

final class NavigationController: UINavigationController {

    var isLightMode: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            isLightMode = true
        case .dark:
            isLightMode = false
        @unknown default:
            isLightMode = true
        }
    }

    func setupBackButton() {
        navigationBar.tintColor = isLightMode ? .black : .white
        navigationBar.backItem?.title = ""
        navigationBar.topItem?.title = " "
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = isLightMode ? .white : .black
        navigationBar.shadowImage = UIImage()
        navigationBar.largeTitleTextAttributes = [.foregroundColor: isLightMode ? UIColor.white : UIColor.black]
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(hex: "#2B2D42"),
            .font: UIFont.systemFont(ofSize: 15)
        ]
    }

    func addLeftBackBarButton() {
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -5
        let backButton = UIBarButtonItem(image: UIImage(named: "back"),
                                         style: .plain,
                                         target: target,
                                         action: #selector(backButtonAction))
        topViewController?.navigationItem.setLeftBarButtonItems([backButton], animated: false)
    }

    @objc
    func backButtonAction() {
        popViewController(animated: true)
    }
}

//
//  Extensions.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 29.01.2026.
//

import SwiftUI
import UIKit

private var loadingViewKey: UInt8 = 0

protocol SwiftUILoaderProtocol: AnyObject {

    func toggleLoading(isLoading: Bool)
}

extension UIViewController: SwiftUILoaderProtocol {

    private var loadingView: LoadingView {
        if let view = objc_getAssociatedObject(self, &loadingViewKey) as? LoadingView {
            return view
        }

        let view = LoadingView()
        view.frame = self.view.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        objc_setAssociatedObject(
            self,
            &loadingViewKey,
            view,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )

        return view
    }

    @discardableResult
    func addSwiftUIView<T: View>(_ swiftUIView: T) -> UIView? {
        let hostingViewController = UIHostingController(rootView: swiftUIView)
        guard let rootView = hostingViewController.view else {
            return nil
        }

        rootView.translatesAutoresizingMaskIntoConstraints = false
        rootView.backgroundColor = .systemBackground

        view.addSubview(rootView)
        NSLayoutConstraint.activate([
            rootView.topAnchor.constraint(equalTo: view.topAnchor),
            rootView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            rootView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rootView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        addChild(hostingViewController)
        hostingViewController.didMove(toParent: self)

        return rootView
    }

    func showLoading() {
        if let window = UIApplication.shared.keyWindow {
            loadingView.show(in: window)
        }
    }

    func hideLoading() {
        loadingView.hide()
    }

    func toggleLoading(isLoading: Bool) {
        switch isLoading {
        case true:
            showLoading()
        case false:
            hideLoading()
        }
    }
}

extension UIColor {

    /// Inits UIColor with hex value
    ///
    /// - Parameter hex: Hex value of color
    public convenience init(hex: String) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        guard cString.count == 6 else {
            self.init(white: 0.5, alpha: 1)
            return
        }

        var rgbValue: UInt64 = 0
        let scanner = Scanner(string: cString)
        scanner.charactersToBeSkipped = nil

        if scanner.scanHexInt64(&rgbValue) {
            let r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(rgbValue & 0x0000FF) / 255.0
            self.init(red: r, green: g, blue: b, alpha: 1.0)
        } else {
            self.init(white: 0.5, alpha: 1)
        }
    }
}

extension Color {

    /// Inits Color with hex value
    ///
    /// - Parameter hex: Hex value of color
    init(hex: String) {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") { cString.removeFirst() }
        guard cString.count == 6 else {
            self = Color(.systemGray)
            return
        }
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        self = Color(
            red: Double((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: Double((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgbValue & 0x0000FF) / 255.0
        )
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat

    static var defaultValue = CGFloat.zero

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct ChildSizeReader<Content: View>: View {
    @Binding var size: CGSize

    let content: () -> Content
    var body: some View {
        ZStack {
            content().background(
                GeometryReader { proxy in
                    Color.clear.preference(
                        key: SizePreferenceKey.self,
                        value: proxy.size
                    )
                }
            )
        }
        .onPreferenceChange(SizePreferenceKey.self) { preferences in
            self.size = preferences
        }
    }
}

struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGSize

    static var defaultValue: Value = .zero

    static func reduce(value _: inout Value, nextValue: () -> Value) {
        _ = nextValue()
    }
}

//
//  MovieDetailViewController.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 31.01.2026.
//

import UIKit

final class MovieDetailViewController: UIViewController {

    private let viewModel: MovieDetailViewModel

    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

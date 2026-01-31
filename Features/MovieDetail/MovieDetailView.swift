//
//  MovieDetailView.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 31.01.2026.
//

import SwiftUI

private enum Constant {

    static let emptyString = ""
    /// 16:9 static frame
    static let carouselHeight: CGFloat = UIScreen.main.bounds.width / 1.77
}

struct MovieDetailView: View {

    @State private var viewModel: MovieDetailViewModelProtocol
    weak var loader: SwiftUILoaderProtocol?

    init(viewModel: MovieDetailViewModel,
         loader: SwiftUILoaderProtocol? = nil) {
        _viewModel = State(initialValue: viewModel)
        self.loader = loader
    }

    var body: some View {
        content
            .task {
                viewModel.onAppear()
            }
            .onChange(of: viewModel.viewState) { _, newValue in
                let condition = [.idle, .loading].contains(newValue)
                loader?.toggleLoading(isLoading: condition)
            }
            .onDisappear {
                viewModel.onDisappear()
            }
    }

    @ViewBuilder private var content: some View {
        switch viewModel.viewState {
        case .idle, .loading:
            EmptyView()
        case .loaded:
            if let movieDetail = viewModel.movieDetail {
                ParallaxView(movieDetail: movieDetail)
            } else {
                EmptyView()
            }
        case .error(let error):
            // - TODO: Create error view
            EmptyView()
        }
    }
}

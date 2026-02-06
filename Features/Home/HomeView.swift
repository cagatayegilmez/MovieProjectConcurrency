//
//  HomeView.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 30.01.2026.
//

import SwiftUI

private enum Constant {

    static let emptyString = ""
    /// 16:9 static frame
    static let carouselHeight: CGFloat = UIScreen.main.bounds.width / 1.77
}

struct HomeView: View {

    @State private var viewModel: HomeViewModelProtocol
    weak var loader: SwiftUILoaderProtocol?
    @State private var wholeSize: CGSize = .zero
    @State private var scrollViewSize: CGSize = .zero
    @State private var invalidateTick: Int = 0
    @State private var changeToken: UUID?
    private let spaceName = "scroll"
    private let placeholder = Color(.systemGray4)

    init(viewModel: HomeViewModel,
         loader: SwiftUILoaderProtocol? = nil) {
        _viewModel = State(initialValue: viewModel)
        self.loader = loader
    }

    var body: some View {
        let _ = invalidateTick

        return content
            .onAppear {
                if changeToken == nil {
                    let tick = $invalidateTick

                    changeToken = viewModel.didChange.observe { [weak loader] _ in
                        tick.wrappedValue += 1
                        let isLoading = [.idle, .loading].contains(viewModel.viewState)
                        loader?.toggleLoading(isLoading: isLoading)
                    }
                }

                viewModel.onAppear()
                loader?.toggleLoading(isLoading: [.idle, .loading].contains(viewModel.viewState))
            }
            .onDisappear {
                if let token = changeToken {
                    viewModel.didChange.remove(token)
                    changeToken = nil
                }
                viewModel.onDisappear()
            }
    }

    @ViewBuilder private var content: some View {
        switch viewModel.viewState {
        case .idle, .loading:
            EmptyView()
        case .loaded:
            SearchView(searchResults: viewModel.searchResults,
                       queryString: $viewModel.queryString) { selectedMovie in
                viewModel.routeToMovieDetail(selectedMovie)
            }
            ChildSizeReader(size: $wholeSize) {
                ScrollView(.vertical, showsIndicators: false) {
                    CarouselView(movieList: viewModel.nowPlayingMovies) { selectedMovie in
                        viewModel.routeToMovieDetail(selectedMovie)
                    }
                    .frame(height: Constant.carouselHeight)
                    ChildSizeReader(size: $scrollViewSize) {
                        VStack {
                            ForEach(viewModel.upcomingMovies, id: \.id) { movie in
                                movieListRow(movie: movie)
                                    .onTapGesture {
                                        viewModel.routeToMovieDetail(movie)
                                    }
                                    .background(
                                        GeometryReader { proxy in
                                            Color.clear.preference(
                                                key: ViewOffsetKey.self,
                                                value: -1 * proxy.frame(in: .named(spaceName)).origin.y
                                            )
                                        }
                                    )
                                    .onPreferenceChange(ViewOffsetKey.self) { value in
                                        if value >= scrollViewSize.height - wholeSize.height {
                                            Task {
                                                await viewModel.loadMoreMovies()
                                            }
                                        }
                                    }
                            }
                        }
                    }
                }
                .refreshable {
                    viewModel.refresh()
                }
                .coordinateSpace(name: spaceName)
            }
        case .error(let error):
            // - TODO: Create error view
            EmptyView()
        }
    }

    @ViewBuilder
    private func movieListRow(movie: MovieListModel) -> some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: movie.imageUrl
                                ?? Constant.emptyString)) { phase in
                switch phase {
                case .empty:
                    placeholder
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    placeholder
                @unknown default:
                    placeholder
                }
            }
            .frame(width: 104, height: 104)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title ?? Constant.emptyString)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(Color(hex: "#2B2D42"))
                Text(movie.overview ?? Constant.emptyString)
                    .font(.system(size: 13))
                    .foregroundColor(Color(hex: "#8D99AE"))
                    .lineLimit(4)
                HStack {
                    Spacer()
                    let dateString = String(Calendar.current.component(.year, from: movie.releaseDate))
                    Text(dateString)
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "#8D99AE"))
                }
            }
            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(Color(hex: "#8D99AE"))
                .padding(.trailing, 6)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .background(Color.white)
    }
}

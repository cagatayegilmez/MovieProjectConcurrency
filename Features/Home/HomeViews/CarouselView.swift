//
//  CarouselView.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 30.01.2026.
//

import SwiftUI

private enum Constant {

    static let emptyString = ""
    static let gradientColors = [Color.white.opacity(0.4), Color.black.opacity(0.6)]
    static let captionVerticalSpacing: CGFloat = 8
    static let titleFont: Font = .system(size: 20, weight: .bold)
    static let subTitleFont: Font = .system(size: 12)
    static let textColor: Color = .white
    static let textHorizontalPadding: CGFloat = 30
    static let textBottomPadding: CGFloat = 24
}

struct CarouselView: View {

    let movieList: [MovieListModel]
    let onSelect: (MovieListModel) -> Void
    private let placeholder = Color(.systemGray4)

    var body: some View {
        TabView {
            ForEach(movieList, id: \.id) { movie in
                CarouselCard(movie: movie,
                             placaholder: placeholder)
                .onTapGesture {
                    onSelect(movie)
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .automatic))
    }

    @ViewBuilder
    private func CarouselCard(movie: MovieListModel,
                              placaholder: Color) -> some View {
        ZStack(alignment: .bottomLeading) {
            let imageUrl = URL(string: movie.imageUrl
                               ?? Constant.emptyString)
            AsyncImage(url: imageUrl) { phase in
                switch phase {
                case .empty:
                    placeholder
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    placeholder
                @unknown default:
                    placeholder
                }
            }
            .clipped()

            LinearGradient(gradient: Gradient(colors: Constant.gradientColors),
                           startPoint: .top,
                           endPoint: .bottom)

            VStack(alignment: .leading,
                   spacing: Constant.captionVerticalSpacing) {
                let dateString = String(Calendar.current.component(.year, from: movie.releaseDate))
                Text("\(movie.title ?? Constant.emptyString) (\(dateString))")
                    .font(Constant.titleFont)
                    .foregroundColor(Constant.textColor)

                Text(movie.overview ?? Constant.emptyString)
                    .font(Constant.subTitleFont)
                    .foregroundColor(Constant.textColor)
            }
            .padding(.horizontal, Constant.textHorizontalPadding)
            .padding(.bottom, Constant.textBottomPadding)
        }
    }
}

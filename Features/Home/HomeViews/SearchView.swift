//
//  SearchView.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 30.01.2026.
//

import SwiftUI

private enum Constant {

    static let searchAreaSpacing: CGFloat = 8
    static let searchAreaHeight: CGFloat = 24
    static let clearButtonTrailing: CGFloat = 20
    static let completeViewHeight: CGFloat = 35
    static let cornerRadius: CGFloat = 12
    static let inputSpace: CGFloat = 12
    static let searchIconSize = CGSize(width: 24, height: 24)
    static let visibleOpacity: Double = 1.0
    static let emptyString = ""
    static let clearIconSize = CGSize(width: 18, height: 18)
    static let placeholderText = "Search movies..."
    static let animationDuration = TimeInterval(0.18)
    static let listViewMaxHeight: CGFloat = 250
    static let horizontalSpacer: CGFloat = 15
    static let listIconSize = CGSize(width: 100, height: 60)
}

struct SearchView: View {

    let searchResults: [MovieListModel]
    @Binding var queryString: String
    let onSelect: (MovieListModel) -> Void

    var body: some View {
        searchView()
        if !searchResults.isEmpty {
            listView()
                .frame(maxHeight: Constant.listViewMaxHeight)
        }
    }

    @ViewBuilder
    private func searchView() -> some View {
        HStack(spacing: Constant.searchAreaSpacing) {
            Spacer(minLength: Constant.horizontalSpacer)
            Image(.searchIcon)
                .resizable()
                .frame(width: Constant.searchIconSize.width,
                       height: Constant.searchIconSize.height)
                .aspectRatio(contentMode: .fill)
            ZStack(alignment: .leading) {
                Text(Constant.placeholderText)
                    .font(Font.system(size: 15))
                    .foregroundColor(.secondary)
                    .opacity(!queryString.isEmpty
                             ? .zero
                             : Constant.visibleOpacity)
                    .allowsHitTesting(false)
                TextField(Constant.emptyString, text: $queryString)
                    .font(Font.system(size: 15))
                    .foregroundColor(.primary)
                    .disableAutocorrection(true)
            }
            .frame(height: Constant.searchAreaHeight)
            if !queryString.isEmpty {
                Button(action: clearAction) {
                    Image(.closeButton)
                        .frame(width: Constant.clearIconSize.width,
                               height: Constant.clearIconSize.height)
                }
                .padding(.trailing, Constant.clearButtonTrailing)
            }
        }
        .frame(height: Constant.completeViewHeight)
        .background(Color(uiColor: .systemBackground))
        .cornerRadius(Constant.cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: Constant.cornerRadius)
                .stroke(Color.secondary)
        )
        .padding(.horizontal, Constant.inputSpace)
    }

    @ViewBuilder
    private func listView() -> some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(searchResults, id: \.self) { item in
                    VStack(alignment: .leading) {
                        HStack(alignment: .center, spacing: Constant.horizontalSpacer) {
                            let url = URL(string: item.imageUrl ?? Constant.emptyString)
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: Constant.listIconSize.width,
                                               height: Constant.listIconSize.height)
                                case .empty, .failure:
                                    EmptyView()
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            Text(item.title ?? Constant.emptyString)
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        .padding(.trailing, Constant.horizontalSpacer)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray.opacity(0.3))
                    }
                    .padding(.leading, Constant.horizontalSpacer)
                    .onTapGesture {
                        onSelect(item)
                    }
                }
            }
        }
        .background(Color(uiColor: .systemBackground))
    }

    private func clearAction() {
        withAnimation(.easeOut(duration: Constant.animationDuration)) {
            queryString = Constant.emptyString
        }
    }
}

//
//  ParallaxView.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 31.01.2026.
//

import SwiftUI

private enum Constant {

    /// 16:9 static frame
    static let headerHeight: CGFloat = UIScreen.main.bounds.width / 1.77
    static let gradinetColors = [Color.white.opacity(0.4), Color.black.opacity(0.6)]
    static let emptyString = ""
}

struct ParallaxView: View {

    let movieDetail: MovieDetailModel
    @State private var scrollMinY: CGFloat = 0
    private let scrollName = "parallaxScroll"

    var body: some View {
        ScrollView {
            VStack {
                StretchyCollapsingHeader(height: Constant.headerHeight,
                                         scrollMinY: scrollMinY,
                                         title: movieDetail.title
                                         ?? Constant.emptyString,
                                         imageLink: movieDetail.imageUrl
                                         ?? Constant.emptyString)
                VStack(alignment: .leading, spacing: 15) {
                    Text(movieDetail.title
                         ?? Constant.emptyString)
                    .font(.system(size: 28, weight: .bold))
                    .padding(.top, 16)

                    Text(movieDetail.overview
                         ?? Constant.emptyString)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Color(.secondaryLabel))
                    .fixedSize(horizontal: false, vertical: true)

                    Spacer(minLength: 28)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
                .background(Color(.systemBackground))
            }
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(
                            key: ScrollMinYKey.self,
                            value: proxy.frame(in: .named(scrollName)).minY
                        )
                }
            )
        }
        .coordinateSpace(name: scrollName)
        .onPreferenceChange(ScrollMinYKey.self) {
            scrollMinY = $0
        }
        .ignoresSafeArea(edges: .top)
        .background(Color(.systemBackground))
    }
}

// MARK: - Header Component
private struct StretchyCollapsingHeader: View {

    let height: CGFloat
    let scrollMinY: CGFloat
    let title: String
    let imageLink: String
    private var placeholder: Color {
        Color(.systemGray4)
    }

    var body: some View {
        let pullDown = max(scrollMinY, 0)
        let scrolledUp = max(-scrollMinY, 0)
        let parallaxY = -scrolledUp * 0.35
        let titleLift = min(scrolledUp, height - 60)
        let overlayOpacity = min(Double(scrolledUp / 220), 1) * 0.35

        ZStack(alignment: .bottomLeading) {
            LinearGradient(
                colors: [Color.black.opacity(0.15), Color.black.opacity(0.85)],
                startPoint: .top,
                endPoint: .bottom
            )
            .overlay(alignment: .center) {
                let imageURL = URL(string: imageLink)
                AsyncImage(url: imageURL) { phase in
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
                .font(.system(size: 56, weight: .bold))
                .foregroundStyle(.white.opacity(0.85))
            }
            .overlay {
                Color.black.opacity(overlayOpacity)
            }
            .frame(height: height + pullDown)
            .frame(maxWidth: .infinity)
            .offset(y: parallaxY)
            .clipped()
            Text(title)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
                .padding(.bottom, 14)
                .offset(y: -titleLift)
                .shadow(radius: 8)
        }
        .frame(height: height)
    }
}

// MARK: - PreferenceKey
private struct ScrollMinYKey: PreferenceKey {

    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

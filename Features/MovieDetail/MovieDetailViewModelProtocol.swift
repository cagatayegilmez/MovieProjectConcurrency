//
//  MovieDetailViewModelProtocol.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 31.01.2026.
//

@MainActor
protocol MovieDetailViewModelProtocol: AnyObject {

    /// State of screen
    var viewState: ViewState { get }

    /// Detail of selected movie
    var movieDetail: MovieDetailModel? { get }

    /// Detail of selected movie
    var similarMovies: [SimilarMoviesListModel] { get }

    /// The method which triggers when screen appears
    func onAppear()

    /// The method which triggers when screen disappears
    func onDisappear()
}

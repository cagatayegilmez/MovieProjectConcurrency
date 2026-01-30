//
//  HomeDataController.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 30.01.2026.
//

final class HomeDataController: HomeDataProtocol {

    private let apiService: ServiceLayer

    init(apiService: ServiceLayer) {
        self.apiService = apiService
    }

    func fetchNowPlayingList() async throws -> MovieModel? {
        let request = GetNowPlayingListRequest()
        return try await apiService.send(request: request)
    }

    func fetchUpcomingList(_ currentPage: Int) async throws -> MovieModel? {
        let request = GetUpcomingListRequest(page: currentPage)
        return try await apiService.send(request: request)
    }

    func searchInMovies(_ query: String, _ currentPage: Int) async throws -> SearchModel? {
        let request = GetSearchResultsRequest(query: query, page: currentPage)
        return try await apiService.send(request: request)
    }
}

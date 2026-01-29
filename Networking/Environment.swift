//
//  Environment.swift
//  MovieProjectConcurrency
//
//  Created by Çağatay Eğilmez on 29.01.2026.
//

import Foundation

/// Environment configuration sourced from `Info.plist`
enum Environment {

    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()

    static let rootURL: URL = {
        guard let rootURLstring = Environment.infoDictionary["API_URL"] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        guard let url = URL(string: rootURLstring) else {
            fatalError("Root URL is invalid")
        }
        return url
    }()

    static let apiKey: String = {
        guard let apiKey = Environment.infoDictionary["API_KEY"] as? String else {
            fatalError("API Key not set in plist for this environment")
        }
        return apiKey
    }()
}

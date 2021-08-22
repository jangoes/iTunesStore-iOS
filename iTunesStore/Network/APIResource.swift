//
//  APIResource.swift
//  iTunesStore
//
//  Created by John Ellie Go on 8/21/21.
//

import Foundation
import Combine

// MARK: - API Resource
protocol APIResource {
    associatedtype ModelType: Decodable
    var methodPath: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension APIResource {
    var url: URL {
        var components = URLComponents(string: "https://itunes.apple.com")!
        components.path = methodPath
        components.queryItems = queryItems
        
        return components.url!
    }
}

// MARK: - Track List Resource
struct TrackListResource: APIResource {
    typealias ModelType = TrackList
    var methodPath = "/search"
    var queryItems = [
        URLQueryItem(name: "term", value: "star"),
        URLQueryItem(name: "country", value: "au"),
        URLQueryItem(name: "media", value: "movie"),
    ]
}

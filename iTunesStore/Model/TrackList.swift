//
//  TrackList.swift
//  iTunesStore
//
//  Created by John Ellie Go on 8/21/21.
//

import Foundation

// MARK: - API RESPONSE
// Wrapper
struct TrackList: Decodable {
    let resultCount: Int
    let results: [Track]
}

// Track list
struct Track: Hashable, Decodable {
    let trackName: String?
    let imageURL: String
    let primaryGenreName: String
    let trackPrice: Double?
    let description, shortDescription, longDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case trackName
        case imageURL = "artworkUrl100"
        case primaryGenreName
        case trackPrice
        case description, shortDescription, longDescription
    }
}

//
//  MockTrackItems.swift
//  iTunesStore
//
//  Created by John Ellie Go on 8/21/21.
//

import Foundation

final class MockTrackItems {
    static let track1 = Track(trackName: "Don't You Wanna Stay (with Kelly Clarkson)",
                             imageURL: "https://is5-ssl.mzstatic.com/image/thumb/Music125/v4/4f/f3/76/4ff37694-4bbb-7769-f3b2-6574a60fd3ae/source/300x300bb.jpg",
                             primaryGenreName: "Country",
                             trackPrice: 16.50,
                             description: "From Director Justin Lin and Producer J.J. Abrams comes one of the best-reviewed action movies of",
                             shortDescription: "From Director Justin Lin and Producer J.J. Abrams comes one of the best-reviewed action movies of",
                             longDescription: "From Director Justin Lin and Producer J.J. Abrams comes one of the best-reviewed action movies of",
                             dateOpened: "01/01/21")

    static let track2 = Track(trackName: "Star Wars: The Last Jedi",
                             imageURL: "https://is5-ssl.mzstatic.com/image/thumb/Music125/v4/4f/f3/76/4ff37694-4bbb-7769-f3b2-6574a60fd3ae/source/300x300bb.jpg",
                             primaryGenreName: "Sci-Fi & Fantasy",
                             trackPrice: 13,
                             description: "From Director Justin Lin and Producer J.J. Abrams comes one of the best-reviewed action movies of",
                             shortDescription: "From Director Justin Lin and Producer J.J. Abrams comes one of the best-reviewed action movies of",
                             longDescription: "From Director Justin Lin and Producer J.J. Abrams comes one of the best-reviewed action movies of")
    
    static let track3 = Track(trackName: "All You Had To Do Was Stay",
                             imageURL: "https://is5-ssl.mzstatic.com/image/thumb/Music125/v4/4f/f3/76/4ff37694-4bbb-7769-f3b2-6574a60fd3ae/source/300x300bb.jpg",
                             primaryGenreName: "Action & Adventrue",
                             trackPrice: 9.99,
                             description: "From Director Justin Lin and Producer J.J. Abrams comes one of the best-reviewed action movies of",
                             shortDescription: "From Director Justin Lin and Producer J.J. Abrams comes one of the best-reviewed action movies of",
                             longDescription: "From Director Justin Lin and Producer J.J. Abrams comes one of the best-reviewed action movies of")
    
    static let trackItems = [
        track1,
        track2,
        track3
    ]
}

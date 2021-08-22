//
//  ContentSection.swift
//  iTunesStore
//
//  Created by John Ellie Go on 8/21/21.
//

import Foundation

struct ContentSectionModel: Hashable {
    let sectionTitle: String
    let items: [Track]
    let type: SectionType
    
    enum SectionType {
        case visited, all
    }
    
    init(sectionTitle: String, items: [Track], type: SectionType = .visited) {
        self.sectionTitle = sectionTitle
        self.items = items
        self.type = type
    }
    
    public init(trackList: TrackList) {
        self.init(sectionTitle: "Tracks", items: trackList.results, type: .all)
    }
}

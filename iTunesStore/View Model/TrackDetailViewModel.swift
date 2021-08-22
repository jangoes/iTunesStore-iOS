//
//  TrackDetailViewModel.swift
//  iTunesStore
//
//  Created by John Ellie Go on 8/22/21.
//

import SwiftUI

class TrackDetailViewModel: ObservableObject {
    let track: Track
    
    let fullScreenWidth = UIScreen.main.bounds.width
    let fullScreenHeight = UIScreen.main.bounds.height
    
    /// use 500x500 image for image quality
    var imageURL: URL {
        URL(string: track.imageURL.replacingOccurrences(of: "100x100", with: "500x500"))!
    }
    
    var trackName: String {
        track.trackName ?? ""
    }
    
    /// return which description isn't nil with the priority of long description > short description > description (may contain html tags - unchecked)
    var description: String {
        track.longDescription ?? track.shortDescription ?? track.description ?? ""
    }
    
    init(track: Track) {
        self.track = track
    }
}

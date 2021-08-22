//
//  RecentTrack+Extension.swift
//  iTunesStore
//
//  Created by RemotoDojo on 8/22/21.
//

import Foundation

extension RecentTrack {
    func convertToTrack() -> Track {
        Track(trackName: trackName,
              imageURL: imageUrl ?? "",
              primaryGenreName: genre ?? "",
              trackPrice: trackPrice,
              description: trackDescription, shortDescription: nil, longDescription: nil)
    }
}

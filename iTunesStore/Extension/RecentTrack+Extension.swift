//
//  RecentTrack+Extension.swift
//  iTunesStore
//
//  Created by John Ellie Go on 8/22/21.
//

import Foundation

extension RecentTrack {
    func convertToTrack() -> Track {
        var dateString: String?
        
        if let dateOpened = dateOpened {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            dateString = formatter.string(from: dateOpened)
        }
        
        return Track(trackName: trackName,
                     imageURL: imageUrl ?? "",
                     primaryGenreName: genre ?? "",
                     trackPrice: trackPrice,
                     description: trackDescription, shortDescription: nil, longDescription: nil,
                     dateOpened: dateString)
    }
}

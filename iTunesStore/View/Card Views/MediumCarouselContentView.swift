//
//  MediumCarouselContentView.swift
//  iTunesStore
//
//  Created by John Ellie Go on 21/8/21.
//

import SwiftUI

struct MediumCarouselContentView: View {
    let trackItem: Track
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            AsyncImage(url: URL(string: trackItem.imageURL
                                    .replacingOccurrences(of: "100x100", with: "300x300"))!) {
                Image("music-placeholder")
                    .resizable()
            }
            .frame(width: 254, height: 156)
            .cornerRadius(15)
            .clipped()
            
            Text(trackItem.primaryGenreName.uppercased())
                .font(.caption2)
                .fontWeight(.bold)
                .foregroundColor(DCColor.darkestText.color)
                .padding(.top, 13)
        
            if let trackName = trackItem.trackName {
                Text(trackName)
                    .font(.headline)    //includes semibold
                    .foregroundColor(DCColor.darkestText.color)
                    .padding(.top, 3)
            }
            
            HStack {
                if let trackprice = trackItem.trackPrice {
                    Text("$ \(String(format: "%.2f", trackprice))")
                        .font(.footnote)
                        .foregroundColor(DCColor.smallListContentFootnote.color)
                }
                
                Spacer()
                
                if let dateOpened = trackItem.dateOpened {
                    Text("Visited at \(dateOpened)")
                        .font(.caption2)
                        .foregroundColor(DCColor.smallListContentFootnote.color)
                        .padding(.trailing, 10)
                }
            }
            .padding(.top, 5.5)
        }
        .frame(width: 254, height: 231, alignment: .center)
    }
}

struct MediumCarouselContentView_Previews: PreviewProvider {
    static var previews: some View {
        MediumCarouselContentView(trackItem: MockTrackItems.track1)
    }
}

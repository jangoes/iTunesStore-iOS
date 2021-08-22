//
//  MediumListContentView.swift
//  iTunesStore
//
//  Created by John Ellie Go on 21/8/21.
//

import SwiftUI

struct MediumListContentView: View {
    let contentItem: Track
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: contentItem.imageURL)!) {
                Image("music-placeholder")
                    .resizable()
            }
            .frame(width: 87, height: 102)
            .cornerRadius(15)
            .clipped()
            
            VStack(alignment: .leading, spacing: 3) {
                Text(contentItem.primaryGenreName.uppercased())
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(DCColor.mediumListContentFootnote.color)
                
                if let trackName = contentItem.trackName {
                    Text(trackName)
                        .font(.headline)
                        .padding(.trailing, 8)
                }
                
                if let trackPrice = contentItem.trackPrice {
                        Text("$ \(String(format: "%.2f", trackPrice))")
                            .font(.footnote)
                            .foregroundColor(DCColor.smallListContentFootnote.color)
                            .padding(.top, 5.5)
                }
            }
            .padding(.top, 11)

            Spacer()
        }
    }
}

struct MediumListContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MediumListContentView(contentItem: MockTrackItems.track2)
        }
    }
}

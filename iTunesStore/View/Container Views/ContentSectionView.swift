//
//  ContentSectionView.swift
//  iTunesStore
//
//  Created by John Ellie Go on 8/21/21.
//

import SwiftUI
import Combine

struct ContentSectionView: View {
    let contentSectionModel: ContentSectionModel
    let trackPublisher: PassthroughSubject<Track, Never>?
    
    private var isRecentlyVisited: Bool {
        contentSectionModel.type == .visited
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(contentSectionModel.sectionTitle)
                    .font(.title)
                    .bold()
                
                Spacer()
            }
            .padding(.horizontal)
            
            if isRecentlyVisited {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(contentSectionModel.items, id: \.self) { track in
                            MediumCarouselContentView(trackItem: track)
                                .onTapGesture {
                                    trackPublisher?.send(track)
                                }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            } else {
                VStack {
                    ForEach(contentSectionModel.items, id: \.self) { track in
                        MediumListContentView(contentItem: track)
                            .padding(.horizontal, 18)
                            .onTapGesture {
                                trackPublisher?.send(track)
                            }
                    }
                }
            }
            
            Spacer()
        }
        .padding(.top, 20)
        .onAppear {
            UITableView.appearance().separatorStyle = .none
        }
    }
}

struct ContentSectionView_Previews: PreviewProvider {
    static let mockData = ContentSectionModel(sectionTitle: "Recently Visited",
                                              items: MockTrackItems.trackItems,
                                              type: .all)
    static var previews: some View {
        ContentSectionView(contentSectionModel: mockData,
                           trackPublisher: nil)
    }
}

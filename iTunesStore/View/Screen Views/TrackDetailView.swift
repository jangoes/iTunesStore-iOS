//
//  TrackDetailView.swift
//  iTunesStore
//
//  Created by John Ellie Go on 8/22/21.
//

import SwiftUI

struct TrackDetailView: View {
    @ObservedObject var trackDetailViewModel: TrackDetailViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                ZStack(alignment: .top) {
                    AsyncImage(url: trackDetailViewModel.imageURL) {
                        Image("music-placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .clipped()
                    
                    VStack(alignment: .leading) {
                        Spacer()
                        
                        ZStack {
                            Rectangle()
                                .fill(
                                    LinearGradient(gradient: Gradient(colors: [.black.opacity(0.2),
                                                                               .clear]),
                                                   startPoint: .bottom, endPoint: .top)
                                )
                            
                            Text(trackDetailViewModel.trackName)
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                                .padding([.leading, .bottom], 10)
                        }
                        .frame(height: 100)
                    }
                }
                
                Text(trackDetailViewModel.description)
                    .padding()
                
                Spacer()
            }
        }
        .onDisappear {
            UserDefaults.standard.didOpenDetailView(value: false)
        }
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct TrackDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TrackDetailView(trackDetailViewModel: TrackDetailViewModel(track: MockTrackItems.track1))
    }
}

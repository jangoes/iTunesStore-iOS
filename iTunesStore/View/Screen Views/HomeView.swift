//
//  HomeView.swift
//  iTunesStore
//
//  Created by John Ellie Go on 8/21/21.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                if homeViewModel.showDetailView, let viewModel = homeViewModel.detailViewModel {
                    NavigationLink(destination: TrackDetailView(trackDetailViewModel: viewModel),
                                   isActive: $homeViewModel.showDetailView) {
                        EmptyView()
                    }
                }
                
                ForEach(homeViewModel.contentSections, id: \.self) { section in
                    if !section.items.isEmpty {
                        ContentSectionView(contentSectionModel: section,
                                           trackPublisher: homeViewModel.selectedTrack)
                    }
                }
            }
            .navigationTitle("Home")
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: homeViewModel.loadTrackItems)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

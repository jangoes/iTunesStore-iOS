//
//  HomeViewModel.swift
//  iTunesStore
//
//  Created by John Ellie Go on 8/22/21.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var isFetching = false
    @Published var contentSections = [ContentSectionModel]()
    @Published var showDetailView = false
    
    var selectedTrack = PassthroughSubject<Track, Never>()
    var detailViewModel: TrackDetailViewModel?
    
    private var request: APIClient<TrackListResource>?
    private var bag = Set<AnyCancellable>()
    
    init() {
        /// - event handler for selected events
        selectedTrack
            .sink(receiveValue: openTrack)
            .store(in: &bag)
        
        /// - recent section
        createRecentSection()
    }
    
    // fetch request
    func loadTrackItems() {
        guard !isFetching else { return }
        isFetching = true
        
        let resource = TrackListResource()
        request = APIClient(using: resource)
        
        /// run api request
        request?.run()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { data in
                let section = ContentSectionModel(trackList: data)
                self.contentSections.append(section)
            }
            .store(in: &bag)
    }
    
    // - detail view
    func openTrack(track: Track) {
        detailViewModel = TrackDetailViewModel(track: track)
        
        let hasExistingTrackName = contentSections.first?.items.filter { $0.trackName == track.trackName }.first?.trackName == track.trackName
        let alreadyExist = contentSections.count > 1 && hasExistingTrackName
        
        /// add to persistence if item does not exist
        if !alreadyExist {
            PersistenceController.shared.addToRecentTrack(track: track, completion: createRecentSection)
        } else {
            PersistenceController.shared.updateRecentTrack(track: track, completion: createRecentSection)
        }
        
        showDetailView = true
    }
    
    // - create / update recent section
    func createRecentSection() {
        let tracks = PersistenceController.shared.fetchRecentTracks()
        
        guard tracks.count > 0 else { return }
        
        let recentSection = ContentSectionModel(sectionTitle: "Recent",
                                                items: tracks)
        
        withAnimation {
            if contentSections.count > 1 {
                contentSections[0] = recentSection
            } else {
                contentSections.insert(recentSection, at: 0)
            }
        }
    }
}

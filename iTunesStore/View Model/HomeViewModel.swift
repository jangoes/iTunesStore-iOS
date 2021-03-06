//
//  HomeViewModel.swift
//  iTunesStore
//
//  Created by John Ellie Go on 8/22/21.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var contentSections = [ContentSectionModel]()
    @Published var isFetching = false
    @Published var showDetailView = false
    
    /// publisher for selected item used in ContentSectionView
    var selectedTrack = PassthroughSubject<Track, Never>()
    
    /// view model for detail view
    var detailViewModel: TrackDetailViewModel?
    
    private var isFirstLoad = true
    private var isDataLoaded = false
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
        
        /// create resource
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
                
                self.isDataLoaded = true
            } receiveValue: { data in
                let section = ContentSectionModel(trackList: data)
                self.contentSections.append(section)
            }
            .store(in: &bag)
    }
    
    // - detail view
    func openTrack(track: Track) {
        detailViewModel = TrackDetailViewModel(track: track)
        
        /// filter first section (core data item value) + get first item and check if trackName matches with param value
        let hasExistingTrackName = contentSections.first?.items.filter {
            $0.trackName == track.trackName
        }
        .first?
        .trackName == track.trackName
        
        /// check if item already exist
        let alreadyExist = isDataLoaded ? contentSections.count == 2 && hasExistingTrackName : contentSections.count <= 2 && hasExistingTrackName

        /// add to persistence if item does not exist
        if !alreadyExist {
            PersistenceController.shared.addToRecentTrack(track: track, completion: createRecentSection)
        } else {
            PersistenceController.shared.updateRecentTrack(track: track, completion: createRecentSection)
        }
        
        /// show detail view
        showDetailView = true
    }
    
    // - create / update recent section
    func createRecentSection() {
        let tracks = PersistenceController.shared.fetchRecentTracks()
        
        guard tracks.count > 0 else { return }
        
        let recentSection = ContentSectionModel(sectionTitle: "Recent",
                                                items: tracks)
        
        withAnimation {
            if contentSections.count <= 1, isDataLoaded {
                contentSections.insert(recentSection, at: 0)
            } else if contentSections.count == 0, !isDataLoaded {
                contentSections.insert(recentSection, at: 0)
            } else {
                contentSections[0] = recentSection
            }
            
            if isFirstLoad {
                isFirstLoad = false
                
                /// - recover previous view state
                if UserDefaults.standard.didOpenDetailView {
                    recoverPreviousView()
                }
            }
        }
    }
    
    // - recover previous view
    func recoverPreviousView() {
        if contentSections[0].items.count > 0 {
            if let lastTrackOpened = contentSections[0].items.first {
                openTrack(track: lastTrackOpened)
            }
        }
    }
}

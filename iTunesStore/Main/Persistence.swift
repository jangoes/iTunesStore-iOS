//
//  Persistence.swift
//  iTunesStore
//
//  Created by John Ellie Go on 8/21/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "iTunesStore")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    // - Add item to RecentTrack
    func addToRecentTrack(track: Track, completion: @escaping () -> Void) {
        let newTrack = RecentTrack(context: container.viewContext)
        newTrack.trackName = track.trackName
        newTrack.imageUrl = track.imageURL
        newTrack.genre = track.primaryGenreName
        newTrack.trackPrice = track.trackPrice ?? 0
        newTrack.trackDescription = track.longDescription ?? track.shortDescription ?? track.description
        newTrack.dateOpened = Date()
        
        saveContext()
        
        DispatchQueue.main.async {
            completion()
        }
    }
    
    // - Update track
    func updateRecentTrack(track: Track, completion: @escaping () -> Void) {
        if let savedTrack = fetchRecentTaskDataObject().filter({ $0.trackName == track.trackName }).first {
            savedTrack.dateOpened = Date()
            
            saveContext()
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    // - Fetch Recent Track
    func fetchRecentTracks() -> [Track] {
        return fetchRecentTaskDataObject().map { $0.convertToTrack() }
    }
    
    func fetchRecentTaskDataObject() -> [RecentTrack] {
        let request = NSFetchRequest<RecentTrack>(entityName: "RecentTrack")
        
        do {
            let response = try container.viewContext.fetch(request).sorted(by: { $0.dateOpened! > $1.dateOpened! })
            return response
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
        
        return [RecentTrack]()
    }
    
    // - Save Changes
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // !!! WARNING: USE FOR TESTING PURPOSES ONLY !!!
    // Delete all track data
    func deleteAllTracks() {
        fetchRecentTaskDataObject().forEach {
            container.viewContext.delete($0)
        }
        
        saveContext()
    }
}

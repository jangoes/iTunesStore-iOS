//
//  iTunesStoreApp.swift
//  iTunesStore
//
//  Created by RemotoDojo on 8/21/21.
//

import SwiftUI

@main
struct iTunesStoreApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

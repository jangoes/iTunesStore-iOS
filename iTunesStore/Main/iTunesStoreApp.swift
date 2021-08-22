//
//  iTunesStoreApp.swift
//  iTunesStore
//
//  Created by John Ellie Go on 8/21/21.
//

import SwiftUI

@main
struct iTunesStoreApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

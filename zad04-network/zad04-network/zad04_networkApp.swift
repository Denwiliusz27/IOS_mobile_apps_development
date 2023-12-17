//
//  zad04_networkApp.swift
//  zad04-network
//
//  Created by Daniel_UJ on 14/12/2023.
//

import SwiftUI

@main
struct zad04_networkApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

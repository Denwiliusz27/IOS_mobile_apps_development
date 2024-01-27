//
//  ContentView.swift
//  Tests
//
//  Created by Daniel_UJ on 27/01/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
            TabView {
                AlarmView()
                    .tabItem {
                        Image(systemName: "clock.fill" )
                        Text("Alarms")
                    }
                
                TaskView()
                    .tabItem {
                        Image(systemName: "checkmark.square")
                        Text("Tasks")
                    }
            }
        }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

//
//  ContentView.swift
//  zad04-network
//
//  Created by Daniel_UJ on 14/12/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.id, ascending: true)],
        animation: .default)
    private var categories: FetchedResults<Category>

    var body: some View {
        NavigationView {
            List {
                ForEach(categories) { category in
                    NavigationLink {
                        ProductsView(categoryId: category.id)
                    } label: {
                        Text(category.name!)
                    }
                }
            }
            Text("Categories")
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

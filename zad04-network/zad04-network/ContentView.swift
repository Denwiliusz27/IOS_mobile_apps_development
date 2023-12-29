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
            VStack {
                Text("Categories")
                    .font(.title)
                    .padding()
                
                List {
                    ForEach(categories) { category in
                        NavigationLink {
                            ProductsView(categoryId: category.id, categoryName: category.name!)
                        } label: {
                            Text(category.name!)
                        }
                    }
                }
                
                NavigationLink(destination: OrdersView()) {
                    Text("Orders")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

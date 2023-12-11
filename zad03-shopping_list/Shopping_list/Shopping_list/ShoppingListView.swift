//
//  ContentView.swift
//  Shopping_list
//
//  Created by Daniel_UJ on 07/12/2023.
//

import SwiftUI
import CoreData

struct ShoppingListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>

    var body: some View {
        NavigationView {
            List {
                ForEach(products) { product in
                    NavigationLink {
                        ItemView(name: product.name!, details: product.details!, amount: product.amount)
                    } label: {
                        HStack{
                            Text(product.name!)
                            Spacer()
                            Text((product.category?.name)!)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            Text("Shopping list")
                .fontWeight(.bold)
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Product(context: viewContext)
            newItem.name = "elo"

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { products[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    ShoppingListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

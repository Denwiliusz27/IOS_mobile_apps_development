//
//  ContentView.swift
//  Payments
//
//  Created by Daniel_UJ on 17/01/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var navigationLinkActive = false
    
    
        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
            animation: .default)
        private var products: FetchedResults<Product>

        var body: some View {
            NavigationView {
                VStack{
                    List {
                        ForEach(products) { product in
                            NavigationLink {
                                ProductView(product: product)
                            } label: {
                                HStack{
                                    Text(product.name!)
                                    Spacer()
                                    Text((product.category?.name)!)
                                }
                            }
                        }
                    }
                    .navigationTitle("Products")
                    
                    Button(action: {
                                        // Dodaj akcję przycisku, która przenosi Cię do ConfirmView
                                        // Na przykład:
                                         navigationLinkActive = true
                                    }) {
                                        Text("Go to ConfirmView")
                                            .padding()
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                    }
                                    // NavigationLink, który jest aktywowany po naciśnięciu przycisku
                                    NavigationLink(
                                        destination: ConfirmPage(),
                                        isActive: $navigationLinkActive,
                                        label: { EmptyView() }
                                    )
                    
                }
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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

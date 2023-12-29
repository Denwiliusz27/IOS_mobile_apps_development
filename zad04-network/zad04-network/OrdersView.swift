//
//  OrdersView.swift
//  zad04-network
//
//  Created by Daniel_UJ on 29/12/2023.
//

import SwiftUI
import CoreData

struct OrdersView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var orders: FetchedResults<Order>
    
    var body: some View{
        VStack {
            Text("Orders")
                .font(.title)
                .padding()
            
            List {
                Section(header: Text("id           shipped                date                      price")){
                    ForEach(orders) { order in
                        HStack{
                            Text(String(order.id))
                            Spacer()
                            Text(order.isShipped ? "true" : "false" )
                            Spacer()
                            Text(order.orderDate!)
                            Spacer()
                            Text(String(order.summaryPrice) + "$")
                        }
                        
                        let productsForOrder = fetchProducts(for: order)
                        ForEach(productsForOrder) { product in
                            Text("\(product.name!) (\(String(format: "%.2f", product.price))$)")
                                .padding(.leading)
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
    }
    
    private func fetchProducts(for order: Order) -> [Product] {
        let orderProductsIDs = order.productsIds
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id IN %@", orderProductsIDs!)

        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching products for order: \(error.localizedDescription)")
            return []
        }
    }
}

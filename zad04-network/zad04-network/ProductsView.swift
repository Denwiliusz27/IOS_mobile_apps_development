//
//  ProductsView.swift
//  zad04-network
//
//  Created by Daniel_UJ on 21/12/2023.
//

import SwiftUI
import CoreData

struct ProductsView: View {
    @Environment(\.managedObjectContext) private var viewContext
        
    var categoryId: Int32
    var categoryName: String
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var products: FetchedResults<Product>
    
        
    init(categoryId: Int32, categoryName: String) {
        self.categoryId = categoryId
        self.categoryName = categoryName
        
        _products = FetchRequest<Product>(
            sortDescriptors: [],
            predicate: NSPredicate(format: "categoryId == %@", argumentArray: [categoryId]),
            animation: .default)
    }
        
    var body: some View {
        VStack {
            Text("Category: \(categoryName)")
                .font(.title)
                .padding()
            List {
                ForEach(products) { product in
                    HStack{
                        Text(product.name!)
                        Spacer()
                        Text(String(product.price))
                    }
                }
            }
        }
    }
}

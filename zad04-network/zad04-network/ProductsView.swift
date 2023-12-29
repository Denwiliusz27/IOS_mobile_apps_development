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
    
    @FetchRequest(
            sortDescriptors: [],
            animation: .default)
    private var products: FetchedResults<Product>
        
    init(categoryId: Int32) {
        self.categoryId = categoryId
        _products = FetchRequest<Product>(
            sortDescriptors: [],
            predicate: NSPredicate(format: "categoryId == %@", argumentArray: [categoryId]),
            animation: .default)
    }
        
    var body: some View {
        List {
            ForEach(products) { product in
                Text(product.name ?? "Unknown")
            }
        }
        Text("Category: \(categoryId)")
    }
}

//
//  ProductView.swift
//  Payments
//
//  Created by Daniel_UJ on 17/01/2024.
//

import SwiftUI

struct ProductView: View {
    let product: Product
    
    var body: some View {
            HStack {
                Text("Item: ")
                    .fontWeight(.bold)
                Text(product.name!)
            }
            HStack {
                Text("Price: ")
                    .fontWeight(.bold)
                Text(String(format: "%.2f", product.price))  //"\(product.price)")
            }
            HStack {
                Text("Details: ")
                    .fontWeight(.bold)
                Text(product.details!)
            }
            
            NavigationLink(destination: PaymentView(product: product)) {
                Text("Buy Item")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
    }
}

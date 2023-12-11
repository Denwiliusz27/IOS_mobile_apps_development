//
//  ItemView.swift
//  Shopping_list
//
//  Created by Daniel_UJ on 11/12/2023.
//

import SwiftUI

struct ItemView: View {
    let name: String
    let details: String
    let amount: Int32
    
    var body: some View {
        HStack {
            Text("Item: ")
                .fontWeight(.bold)
            Text("\(name)")
        }
        HStack {
            Text("Amount: ")
                .fontWeight(.bold)
            Text("\(amount)")
        }
        HStack {
            Text("Details: ")
                .fontWeight(.bold)
            Text("\(details)")
        }
            
    }
}

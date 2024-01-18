//
//  ConfirmView.swift
//  Payments
//
//  Created by Daniel_UJ on 18/01/2024.
//

import SwiftUI

struct ConfirmView: View{
    let product: Product
    
    var body: some View {
        VStack{
            Text("You successfuly bought \(product.name!)")
        }
    }
}

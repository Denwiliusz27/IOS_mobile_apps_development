//
//  ConfirmPage.swift
//  Payments
//
//  Created by Daniel_UJ on 17/01/2024.
//

import SwiftUI

struct ConfirmPage: View {
    let product: Product
    
    var body: some View {
        VStack{
            Text("You successfuly bought \(product.name!)!")
        }
    }
}

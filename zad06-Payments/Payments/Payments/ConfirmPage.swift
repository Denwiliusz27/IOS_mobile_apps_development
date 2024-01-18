//
//  ConfirmPage.swift
//  Payments
//
//  Created by Daniel_UJ on 18/01/2024.
//

import SwiftUI

struct ConfirmPage: View {
    @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Bought.date, ascending: true)],
            animation: .default)
    private var boughts: FetchedResults<Bought>
    
    var body: some View {
        VStack{            
            List {
                ForEach(boughts) { bought in
                    HStack{
                        Text((bought.product?.name)!)
                        Spacer()
                        Text(String(format: "%.2f", bought.product!.price))
                        Spacer()
                        Text("Date: \(formatDate(bought.date))")
                                    .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Previously bought:")
        }
    }
    
    func formatDate(_ date: Date?) -> String {
        guard let date = date else {
            return "Unknown Date"
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Dostosuj format daty według własnych preferencji

        return dateFormatter.string(from: date)
    }
}

//
//  TimeInputField.swift
//  Tests
//
//  Created by Daniel_UJ on 27/01/2024.
//

import SwiftUI

struct TimeInputField: View {
    let inputName: String
    @Binding var value: String
    
    var body: some View {
        TextField("\(inputName)", text: $value)
            .frame(width: 70, height: 60, alignment: .center)
            .background(Color.white)
            .cornerRadius(15)
            .fontWeight(.bold)
            .font(.system(size: 20))
            .padding(.horizontal, 10)
            .multilineTextAlignment(.center)
    }
}

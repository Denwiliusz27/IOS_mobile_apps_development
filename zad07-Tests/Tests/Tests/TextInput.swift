//
//  TextInput.swift
//  Tests
//
//  Created by Daniel_UJ on 27/01/2024.
//

import SwiftUI

struct TextInput: View {
    let inputName: String
    @Binding var value: String
    
    var body: some View {
        TextField("\(inputName)", text: $value)
            .frame(width: 200, height: 50, alignment: .center)
            .padding(.horizontal, 15)
            .background(Color.white)
            .foregroundColor(.blue)
            .cornerRadius(15)
            .fontWeight(.bold)
            .font(.system(size: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.blue, lineWidth: 3)
            )
            .padding(.vertical, 3)
    }
}


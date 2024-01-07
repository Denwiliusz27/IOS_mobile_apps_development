//
//  TextInput.swift
//  zad05-OAuth
//
//  Created by Daniel_UJ on 07/01/2024.
//
import SwiftUI
import Foundation

struct TextInput: View {
    let inputName: String
    @Binding var value: String
    
    var body: some View {
        TextField("\(inputName)", text: $value)
            .frame(width: 260, height: 60, alignment: .center)
            .padding(.horizontal, 20)
            .background(Color.white)
            .foregroundColor(.blue)
            .cornerRadius(15)
            .fontWeight(.bold)
            .font(.system(size: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.blue, lineWidth: 3)
            )
            .padding(.vertical, 5)
    }
}

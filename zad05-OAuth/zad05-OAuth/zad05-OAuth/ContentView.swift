//
//  ContentView.swift
//  zad05-OAuth
//
//  Created by Daniel_UJ on 04/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoginHovered = false
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Hello in our App!")
                    .font(.title)
                    .padding()
                
                NavigationLink(destination: LoginView()) {
                    Text("Login")
                        .frame(width: 300, height: 80, alignment: .center)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .fontWeight(.bold)
                        .font(.system(size:20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.black, lineWidth: 3)
                        )
                }
                .padding(.vertical,  30)
                
                NavigationLink(destination: RegisterView()) {
                    Text("Register")
                        .frame(width: 300, height: 80, alignment: .center)
                        .background(Color.white)
                        .foregroundColor(.blue)
                        .cornerRadius(15)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.blue, lineWidth: 3)
                        )
                }
                .padding(.vertical,  30)
            }
        }
    }
}

#Preview {
    ContentView()
}

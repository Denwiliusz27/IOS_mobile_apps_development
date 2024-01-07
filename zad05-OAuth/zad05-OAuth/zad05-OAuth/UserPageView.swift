//
//  UserPageView.swift
//  zad05-OAuth
//
//  Created by Daniel_UJ on 06/01/2024.
//

import SwiftUI
import Foundation

struct UserPageView: View {
    var user: User
    
    var body: some View{
        Text("Hello \(user.name)!")
        Text("Age: \(user.age)")
//        Text("City: \(user.city)")
    }
}

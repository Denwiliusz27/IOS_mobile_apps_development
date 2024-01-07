//
//  User.swift
//  zad05-OAuth
//
//  Created by Daniel_UJ on 06/01/2024.
//

import Foundation

class User: Codable {
    var name: String
    var age: Int
    var city: String
    
    init(name: String, age: Int, city: String) {
        self.name = name
        self.age = age
        self.city = city
    }
}

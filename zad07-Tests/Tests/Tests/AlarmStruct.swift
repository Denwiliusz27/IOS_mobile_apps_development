//
//  AlarmStruct.swift
//  Tests
//
//  Created by Daniel_UJ on 29/01/2024.
//
import SwiftUI

struct Alarm: Identifiable {
    let id = UUID()
    var day: String
    var hour: Int
    var minute: Int
}

//
//  TaskView.swift
//  zad02-task_list
//
//  Created by Daniel_UJ on 23/11/2023.
//

import SwiftUI

struct TaskView: View {
    let name: String
    let description: String
    let image: String

    
    var body: some View {
        Text("Task: \(name)")
            .fontWeight(.bold)
            .padding(20)
        Text("Description: \(description)")
        Image(image)
            .resizable()
            .scaledToFit()
    }
}

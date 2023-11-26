//
//  ContentView.swift
//  zad02-task_list
//
//  Created by Daniel_UJ on 23/11/2023.
//

import SwiftUI

struct ContentView: View {
    struct Task: Identifiable {
        let id = UUID()
        var name: String
        var priority: String
        var description: String
        var image: String
    }
    
    @State var taskList: [Task] = [
        Task(name: "buy ziemniaki", priority: "High", description: "Buy some potatoes for dinner", image: "potatoes"),
        Task(name: "walk a dog", priority: "Low", description: "Burek needs to go outside", image: "dog"),
        Task(name: "do task for IOS", priority: "High", description: "It won't take longer than 15 min", image: "ios")
    ]
    
    
    
    var body: some View {
        Text("Task list")
            .fontWeight(.bold)
            .font(.title)
            .foregroundStyle(Color.red)
            .padding(20)
        
        NavigationStack{
            List {
                ForEach(taskList) { task in
                    NavigationLink {
                        TaskView(name: task.name, description: task.description, image: task.image)
                    } label:{
                        HStack{
                            Text(task.name)
                            Spacer()
                            Text(task.priority)
                        }
                    }
                    .padding(15)
                    .swipeActions(edge: .leading) {
                        Button(role: .destructive) {
                            taskList.removeAll { $0.id == task.id }
                            print("Delete item")
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

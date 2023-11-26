//
//  ContentView.swift
//  zad02-task_list
//
//  Created by Daniel_UJ on 23/11/2023.
//

import SwiftUI

struct ContentView: View {
    struct Task: Identifiable {
        let id = Int()
        var name: String
        var description: String
        var image: String
        var status: String
    }
    
    @State var taskList: [Task] = [
        Task(name: "buy ziemniaki", description: "Buy some potatoes for dinner", image: "potatoes", status: "To do"),
        Task(name: "walk a dog", description: "Burek needs to go outside", image: "dog", status: "Done"),
        Task(name: "do task for IOS", description: "It won't take longer than 15 min", image: "ios", status: "In progress")
    ]
    
    
    var body: some View {
        Text("Tasks list")
            .fontWeight(.bold)
            .font(.title)
            .foregroundStyle(Color.red)
            .padding(20)
        
        NavigationStack{
            List {
                ForEach(taskList.indices, id: \.self) { index in
                    NavigationLink {
                        TaskView(name: taskList[index].name, description: taskList[index].description, image: taskList[index].image)
                    } label:{
                        HStack{
                            Text(taskList[index].name)
                            Spacer()
                            
                            Menu{
                                Button(action: {
                                    taskList[index].status = "To do"
                                }, label: {
                                    Text("To do")
                                })
                                Button(action: {
                                    taskList[index].status = "In Progress"
                                }, label: {
                                    Text("In progress")
                                })
                                Button(action: {
                                    taskList[index].status = "Done"
                                }, label: {
                                    Text("Done")
                                })
                            } label: {
                                Label(
                                    title: { Text(taskList[index].status) },
                                    icon: {  }
                                )
                            }
                        }
                    }
                    .padding(15)
                    .swipeActions(edge: .leading) {
                        Button(role: .destructive) {
                            taskList.remove(at: index)
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

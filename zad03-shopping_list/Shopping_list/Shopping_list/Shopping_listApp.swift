//
//  Shopping_listApp.swift
//  Shopping_list
//
//  Created by Daniel_UJ on 07/12/2023.
//

import SwiftUI
import CoreData

@main
struct Shopping_listApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        loadData()
    }
    
    var body: some Scene {
        WindowGroup {
            ShoppingListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

extension Shopping_listApp {
    func loadData() {
        let context = persistenceController.container.viewContext
        
        if !isDataLoaded(){
            let milk = Product(context: context)
            milk.name = "Milk"
            

            let bread = Product(context: context)
            bread.name = "Bread"
            
            
            let laptop = Product(context: context)
            laptop.name = "Laptop"
                    
            
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func isDataLoaded() -> Bool {
        let context = persistenceController.container.viewContext
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            let products = try context.fetch(request)
            return !products.isEmpty
        } catch {
            return false
        }
        
    }
}


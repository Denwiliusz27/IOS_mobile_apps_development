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
            let electronicsCategory = Category(context: context)
            electronicsCategory.name = "Electronics"
            
            let dairyCategory = Category(context: context)
            dairyCategory.name = "Dairy"
            
            let breadCategory = Category(context: context)
            breadCategory.name = "Bread"
            
            let milk = Product(context: context)
            milk.name = "Milk"
            milk.details = "From Mlekowita"
            milk.amount = 2
            milk.category = dairyCategory
            
            let cheese = Product(context: context)
            cheese.name = "Cheese"
            cheese.details = "With big holes"
            cheese.amount = 1
            cheese.category = dairyCategory
            
            let eggs = Product(context: context)
            eggs.name = "Eggs"
            eggs.details = "From free chikens"
            eggs.amount = 2
            eggs.category = dairyCategory
 
            let bread = Product(context: context)
            bread.name = "Bread"
            bread.details = "Wholegrain"
            bread.amount = 1
            bread.category = breadCategory
            
            let kaiser = Product(context: context)
            kaiser.name = "Kaiser"
            kaiser.details = "Well baked"
            kaiser.amount = 4
            kaiser.category = breadCategory
            
            let laptop = Product(context: context)
            laptop.name = "Laptop"
            laptop.details = "With good graphic, procesor and RAM memory"
            laptop.amount = 1
            laptop.category = electronicsCategory
            
            print("dodaje")
            
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
            print("nic do dodania")
            return false
        }
        
    }
}


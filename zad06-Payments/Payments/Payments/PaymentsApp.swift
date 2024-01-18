//
//  PaymentsApp.swift
//  Payments
//
//  Created by Daniel_UJ on 17/01/2024.
//

import SwiftUI
import CoreData

@main
struct PaymentsApp: App {
    let persistenceController = PersistenceController.shared

    init(){
        loadData()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

extension PaymentsApp {
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
                    milk.price = 2.99
                    milk.category = dairyCategory
                    
                    let cheese = Product(context: context)
                    cheese.name = "Cheese"
                    cheese.details = "With big holes"
                    cheese.price = 5.49
                    cheese.category = dairyCategory
                    
                    let eggs = Product(context: context)
                    eggs.name = "Eggs"
                    eggs.details = "From free chikens"
                    eggs.price = 10.99
                    eggs.category = dairyCategory
         
                    let bread = Product(context: context)
                    bread.name = "Bread"
                    bread.details = "Wholegrain"
                    bread.price = 4.00
                    bread.category = breadCategory
                    
                    let kaiser = Product(context: context)
                    kaiser.name = "Kaiser"
                    kaiser.details = "Well baked"
                    kaiser.price = 0.59
                    kaiser.category = breadCategory
                    
                    let laptop = Product(context: context)
                    laptop.name = "Laptop"
                    laptop.details = "With good graphic, procesor and RAM memory"
                    laptop.price = 1299.00
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

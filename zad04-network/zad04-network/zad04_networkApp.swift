//
//  zad04_networkApp.swift
//  zad04-network
//
//  Created by Daniel_UJ on 14/12/2023.
//

import SwiftUI
import CoreData

@main
struct zad04_networkApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        loadCategories()
        loadProducts()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

extension zad04_networkApp {
    func loadCategories() {
        let context = persistenceController.container.viewContext
        let serverUrl = "https://f010-2a02-a31a-e045-4880-d5d2-d149-1cf7-f275.ngrok-free.app/categories"
        
        let url = URL(string: serverUrl)
        let request = URLRequest(url: url!)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let categoryEntity = NSEntityDescription.entity(forEntityName: "Category", in: context)
        let dispathGroup = DispatchGroup()
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard error == nil else {
                print("Error requesting data from server")
                return
            }

            guard data != nil else {
                print("No categories")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                if let object = json as? [String : Any] {
                    print(object)
                } else if let object = json as? [Any] {
                    for item in object as! [Dictionary<String, AnyObject>] {
                        let id = item["id"] as! Int32
                        let name = item["name"] as! String
                        
                        if !checkIfExists(model: "Category", field: "name", fieldValue: item["name"] as! String) {
                            let category = NSManagedObject(entity: categoryEntity!, insertInto: context)
                            category.setValue(id, forKey: "id")
                            category.setValue(name, forKey: "name")
                            print("Added category: name:\(name), id:\(id)")
                        } else {
                            print("Category: name:\(name), id: \(id) is already in DB")
                        }
                    }
                    try context.save()
                    dispathGroup.leave()
                } else {
                    print("Error with JSON")
                }
            } catch {
                print("error receiving response for Categories")
                dispathGroup.leave()
                return
            }
        })
        dispathGroup.enter()
        task.resume()
        dispathGroup.wait()
    }
    
    func loadProducts() {
        let context = persistenceController.container.viewContext
        let serverUrl = "https://f010-2a02-a31a-e045-4880-d5d2-d149-1cf7-f275.ngrok-free.app/products"
        
        let url = URL(string: serverUrl)
        let request = URLRequest(url: url!)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let productEntity = NSEntityDescription.entity(forEntityName: "Product", in: context)
        let dispathGroup = DispatchGroup()
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard error == nil else {
                print("Error requesting data from server")
                return
            }

            guard data != nil else {
                print("No products")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                if let object = json as? [String : Any] {
                    print(object)
                } else if let object = json as? [Any] {
                    for item in object as! [Dictionary<String, AnyObject>] {
                        let id = item["id"] as! Int32
                        let name = item["name"] as! String
                        let categoryId = item["categoryId"] as! Int32
                        
                        if !checkIfExists(model: "Product", field: "name", fieldValue: item["name"] as! String) {
                            let product = NSManagedObject(entity: productEntity!, insertInto: context)
                            product.setValue(id, forKey: "id")
                            product.setValue(name, forKey: "name")
                            product.setValue(categoryId, forKey: "categoryId")
                            print("Added product: name:\(name), id:\(id), categoryId: \(categoryId)")
                        } else {
                            print("Product: name:\(name), id: \(id), categoryId: \(categoryId) is already in DB")
                        }
                    }
                    try context.save()
                    dispathGroup.leave()
                } else {
                    print("Error with JSON")
                }
            } catch {
                print("error receiving response for Products")
                dispathGroup.leave()
                return
            }
        })
        dispathGroup.enter()
        task.resume()
        dispathGroup.wait()
    }
    
    func checkIfExists(model: String, field: String, fieldValue: String) -> Bool {
            let context = persistenceController.container.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: model)
            fetchRequest.predicate = NSPredicate(format: "\(field) = %@", fieldValue)
            
            do {
                let fetchResults = try context.fetch(fetchRequest) as? [NSManagedObject]
                if fetchResults!.count > 0 {
                    return true
                }
                return false
            } catch {
                print("Error in checkIfExist")
            }
            return false
        }
    
    
}

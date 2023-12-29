//
//  zad04_networkApp.swift
//  zad04-network
//
//  Created by Daniel_UJ on 14/12/2023.
//

import SwiftUI
import CoreData

let basicServerUrl = "https://a119-83-28-163-66.ngrok-free.app"

@main
struct zad04_networkApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        loadCategories()
        loadProducts()
        loadOrders()
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
        let serverUrl = basicServerUrl + "/categories"
        
        let url = URL(string: serverUrl)
        let request = URLRequest(url: url!)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let categoryEntity = NSEntityDescription.entity(forEntityName: "Category", in: context)
        let dispathGroup = DispatchGroup()
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard error == nil else {
                print("Error requesting data from server for category")
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
        let serverUrl = basicServerUrl + "/products"
        
        let url = URL(string: serverUrl)
        let request = URLRequest(url: url!)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let productEntity = NSEntityDescription.entity(forEntityName: "Product", in: context)
        let dispathGroup = DispatchGroup()
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard error == nil else {
                print("Error requesting data from server for products")
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
                        let price = item["price"] as! Double
                        
                        if !checkIfExists(model: "Product", field: "name", fieldValue: item["name"] as! String) {
                            let product = NSManagedObject(entity: productEntity!, insertInto: context)
                            product.setValue(id, forKey: "id")
                            product.setValue(name, forKey: "name")
                            product.setValue(categoryId, forKey: "categoryId")
                            product.setValue(price, forKey: "price")
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
    
    func loadOrders() {
        let context = persistenceController.container.viewContext
        let serverUrl = basicServerUrl + "/orders"
        
        let url = URL(string: serverUrl)
        let request = URLRequest(url: url!)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let orderEntity = NSEntityDescription.entity(forEntityName: "Order", in: context)
        let dispathGroup = DispatchGroup()
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard error == nil else {
                print("Error requesting data from server for orders")
                return
            }

            guard data != nil else {
                print("No orders")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                if let object = json as? [String : Any] {
                    print(object)
                } else if let object = json as? [Any] {
                    for item in object as! [Dictionary<String, AnyObject>] {
                        let id = item["id"] as! Int32
                        let orderDate = item["orderDate"] as! String
                        let isShipped = item["isShipped"] as! Bool
                        let productsIds = item["productsIds"] as! [Int32]
                        let summaryPrice = item["summaryPrice"] as! Double
                        
                        if !checkIfExists(model: "Order", field: "orderDate", fieldValue: item["orderDate"] as! String) {
                            let order = NSManagedObject(entity: orderEntity!, insertInto: context)
                            order.setValue(id, forKey: "id")
                            order.setValue(orderDate, forKey: "orderDate")
                            order.setValue(isShipped, forKey: "isShipped")
                            order.setValue(productsIds, forKey: "productsIds")
                            order.setValue(summaryPrice, forKey: "summaryPrice")
                            print("Added order: products:\(productsIds), price:\(summaryPrice)")
                        } else {
                            print("Order: products:\(productsIds), price:\(summaryPrice) is already in DB")
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

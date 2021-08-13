//
//  PersistenceController.swift
//  MySecretary
//
//  Created by jang gukjin on 2021/08/13.
//

import CoreData
import UIKit

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController()
        let viewContext = result.container.viewContext
        for i in 0 ..< 10 {
            let newItem = Item(context: viewContext)
            newItem.contents = "Item #\(i)"
            newItem.image = UIImage(systemName: "multiply.circle.fill")
            newItem.date = Date()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "MySecretary")
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}


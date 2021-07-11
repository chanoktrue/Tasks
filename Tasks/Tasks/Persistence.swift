//
//  Persistence.swift
//  Tasks
//
//  Created by Thongchai Subsaidee on 11/7/2564 BE.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Tasks")
        container.loadPersistentStores { NSPersistentStoreDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error)")
            }
        }
    }
}

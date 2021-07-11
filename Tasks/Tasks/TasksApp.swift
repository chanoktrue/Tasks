//
//  TasksApp.swift
//  Tasks
//
//  Created by Thongchai Subsaidee on 11/7/2564 BE.
//

import SwiftUI

@main
struct TasksApp: App {
    
    let persistenceContainer = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
        }
    }
}

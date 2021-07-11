//
//  ContentView.swift
//  Tasks
//
//  Created by Thongchai Subsaidee on 11/7/2564 BE.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: false)])
    private var tasks: FetchedResults<Task>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { task in
                    HStack {
                        Text(task.title ?? "Untitled")
                            .onTapGesture {
                                updateTask(task)
                            }
                        
                        Spacer()
                        
                        Image(systemName: task.done ? "checkmark" : "xmark")
                    }
                }
                .onDelete(perform: deleteTask)
            }
            .navigationBarTitle("Task list")
            .navigationBarItems(trailing: Button("Add", action: {
                addTask()
            }))
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        }catch{
            let error = error as NSError
            fatalError("Unresolved error: \(error )")
        }
    }
    
    private func addTask() {
        withAnimation {
            let task = Task(context: viewContext)
            task.title = "New task \(Date())"
            task.date = Date()
            task.done = false
            saveContext()
        }
    }
    
    private func deleteTask(offsets: IndexSet) {
        withAnimation {
            offsets.map{tasks[$0]}.forEach(viewContext.delete)
            saveContext()
        }
    }
    
    private func updateTask(_ task: FetchedResults<Task>.Element) {
        withAnimation {
            task.done.toggle()
            saveContext()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

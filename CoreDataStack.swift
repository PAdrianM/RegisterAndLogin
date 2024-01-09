//
//  CoreDataStack.swift
//  RegisterAndLogin
//
//  Created by Andrea Hernandez on 1/9/24.
//

import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UserAttributes")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Error al cargar el modelo de datos: \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    func saveContext() throws {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                throw error
            }
        }
    }
}

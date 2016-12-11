//
//  CoreDataManager.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 04.12.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    // Singleton
    static let instance = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SBMedicalReminder")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Load persistent store error occurred \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Application did not save data with reason: \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentContainer.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    func entityForName(_ entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: self.managedObjectContext)!
    }
    
    func fetchedResultsController(_ entityName: String, keyForSort: String) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: keyForSort, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }
}

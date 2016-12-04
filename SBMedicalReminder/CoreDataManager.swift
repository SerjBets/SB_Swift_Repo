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
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func entityForName(entityName: String) -> NSEntityDescription {
        let context = getContext()
        return NSEntityDescription.entity(forEntityName: entityName, in: context)!
    }
    
    func fetchedResultsController(entityName: String, keyForSort: String) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: keyForSort, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.getContext(), sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }
    
    func saveContext () {
        let context = getContext()
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
}

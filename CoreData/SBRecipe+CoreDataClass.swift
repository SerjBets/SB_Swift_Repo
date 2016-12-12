//
//  SBRecipe+CoreDataClass.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 04.12.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import Foundation
import CoreData

//@objc(SBRecipe)
class SBRecipe: NSManagedObject {
    
//CoreData keys
    static let kMedicamentName  = "medicamentName"
    static let kMedicamentType  = "medicamentType"
    static let kPeriodCourse    = "periodCourse"
    static let kTimesDay        = "timesDay"
    static let kMealCheck       = "mealCheck"
    static let kMealTime        = "mealTime"
    
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "SBRecipe"), insertInto: CoreDataManager.instance.managedObjectContext)
    }
}

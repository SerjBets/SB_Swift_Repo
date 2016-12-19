//
//  SBRecipe+CoreDataProperties.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 13.12.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import Foundation
import CoreData


extension SBManagedRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SBManagedRecipe> {
        return NSFetchRequest<SBManagedRecipe>(entityName: "SBRecipe");
    }

    @NSManaged public var mealCheck: Bool
    @NSManaged public var mealTime: Int16
    @NSManaged public var medicamentName: String?
    @NSManaged public var medicamentType: String?
    @NSManaged public var periodCourse: Int16
    @NSManaged public var timesDay: Int16
    @NSManaged public var date: Date?

}

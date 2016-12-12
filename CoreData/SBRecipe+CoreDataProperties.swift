//
//  SBRecipe+CoreDataProperties.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 04.12.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import Foundation
import CoreData


extension SBRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SBRecipe> {
        return NSFetchRequest<SBRecipe>(entityName: "SBRecipe");
    }

    @NSManaged public var mealCheck: Bool
    @NSManaged public var mealTime: Int16
    @NSManaged public var medicamentName: String?
    @NSManaged public var medicamentType: String?
    @NSManaged public var periodCourse: Int16
    @NSManaged public var timesDay: Int16

}

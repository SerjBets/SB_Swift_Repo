//
//  SBRecipe+CoreDataClass.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 04.12.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import Foundation
import CoreData

@objc(SBRecipe)
class SBRecipe: NSManagedObject {

    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName("SBRecipeEntity"), insertInto: CoreDataManager.instance.managedObjectContext)
    }
}

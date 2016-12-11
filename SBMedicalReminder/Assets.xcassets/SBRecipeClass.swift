//
//  SBRecipeClass.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 03.12.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import UIKit
import CoreData

class SBRecipeClass: NSManagedObject {
    var medicamentName = ""
    var medicamentType = ""
    var periodCourse: Int8 = 0
    var timeDay: Int8 = 0
    var mealCheck: Bool = false
    var mealTime: Int8 = 0
}

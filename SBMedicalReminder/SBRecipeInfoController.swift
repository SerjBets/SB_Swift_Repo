//
//  SBRecipeInfoController.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 13.12.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import Foundation
import UIKit

class SBRecipeInfoController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var timesPedDay: UILabel!
    @IBOutlet weak var meal: UILabel!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var daysLeft: UILabel!
    
    var recipeInfo : SBRecipe!
    
    
//MARK: viewControllers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tempDaysGo = daysBetweenDates(startDate: Date(), endDate: recipeInfo.date as! Date)
        let tempdaysLeft = recipeInfo.periodCourse - tempDaysGo
        
        name.text           = " \(recipeInfo.medicamentName!)"
        type.text           = " \(recipeInfo.medicamentType!)"
        period.text         = " \(recipeInfo.periodCourse)"
        timesPedDay.text    = " \(recipeInfo.timesDay)"
        days.text           = " \(tempDaysGo)"
        daysLeft.text       = " \(tempdaysLeft)"
        
        if (recipeInfo.mealCheck) {
            meal.text = "Take medicament \(recipeInfo.mealTime) min After meal"
        } else {
            meal.text = "Take medicament \(recipeInfo.mealTime) min Before meal"
        }
    }
    
    func daysBetweenDates(startDate: Date, endDate: Date) -> Int
    {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([Calendar.Component.day], from: startDate, to: endDate)
        return components.day!
    }
}

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
    
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var timesPedDay: UILabel!
    @IBOutlet weak var meal: UILabel!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var daysLeft: UILabel!
    
    var recipeInfo : SBRecipe!
    var timer = Timer()
    
//MARK: viewControllers
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerClock), userInfo: nil, repeats: true)
        
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
    
//MARK: - Timer
    func timerClock() {
        let date = Date()
        let dateFormatter = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .medium)
        clockLabel.text = dateFormatter
    }
}

//
//  SBAddRecipeController.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 27.11.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import UIKit
import CoreData

class SBAddRecipeController: UIViewController, UITextFieldDelegate {
    
//MARK: - IBOutlets
    @IBOutlet weak var medicamentName: UITextField!
    @IBOutlet weak var medicamentType: UITextField!
    @IBOutlet weak var periodCourseSlider: UISlider!
    @IBOutlet weak var timesDaySegControl: UISegmentedControl!
    @IBOutlet weak var mealSwitch: UISwitch!
    @IBOutlet weak var mealSegContol: UISegmentedControl!
    @IBOutlet weak var timeClockLabel: UILabel!
    @IBOutlet weak var periodCourseLabel: UILabel!
    
    var timer = Timer()
    let alert = SBAlertManager()
    let keys = SBKeysAndSegue()
    
    
//MARK: viewController
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerClock), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
//MARK: - Actions
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        if textFieldIsEmpty() != true {
            saveRecipe()
            performSegue(withIdentifier: keys.segueAddToRecipesTable, sender: nil)
        }
    }
    
    @IBAction func periodSliderAction(_ sender: UISlider) {
        let temp : Int = Int(periodCourseSlider.value)
        periodCourseLabel.text = temp.description
    }
    
//MARK: CoreDataDelegate
    func saveRecipe() {
        let entity = CoreDataManager.instance.entityForName(entityName: "SBRecipe")
        let context = CoreDataManager.instance.managedObjectContext
        let newRecipe = SBManagedRecipe(entity:entity, insertInto:context)
        newRecipe.medicamentName = medicamentName.text
        newRecipe.medicamentType = medicamentType.text
        newRecipe.periodCourse = Int16(periodCourseSlider.value)
        newRecipe.mealCheck = mealSwitch.isOn
        newRecipe.mealTime = Int16(mealSegContol.titleForSegment(at: mealSegContol.selectedSegmentIndex)!)!
        newRecipe.timesDay = Int16(timesDaySegControl.titleForSegment(at: timesDaySegControl.selectedSegmentIndex)!)!
        newRecipe.date = Date()

        CoreDataManager.instance.saveContext()
    }
    
//MARK: - TextFieldDelegate
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        if textField == medicamentName {
            medicamentType.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldIsEmpty() -> Bool {
        guard medicamentName.text?.isEmpty == false else {
            alert.showAlertFromController(controller: self, message: "Enter medicament name!")
            return true
        }
        guard medicamentType.text?.isEmpty == false else {
            alert.showAlertFromController(controller: self, message: "Enter medicament type!")
            return true
        }
        return false
    }
    
//MARK: - Timer
    func timerClock() {
        let date = Date()
        let dateFormatter = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .medium)
        timeClockLabel.text = dateFormatter
    }
    
//MARK: - segue
    func prepareForSegue(segue: UIStoryboardSegue, sender: SBManagedRecipe?) {
        if segue.identifier == keys.segueAddToRecipesTable {
            _ = segue.destination as! SBAddRecipeController
        }
        if segue.identifier == keys.segueRecipeTableToRecipeInfo {
            
        }
    }
}


//
//  SBAddRecipeController.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 27.11.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import UIKit
import CoreData

class SBAddRecipeController: UIViewController {
    
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
    var recipe : SBRecipe?
    
    
//MARK: - Actions
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        if textFieldCheckEmpty() {
            saveRecipe()
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func periodSliderAction(_ sender: UISlider) {
        let temp : Int = Int(periodCourseSlider.value)
        periodCourseLabel.text = temp.description
    }
    
//MARK: CoreDataDelegate
    func saveRecipe() {
        if recipe == nil {
            recipe = SBRecipe()
        } else {
            recipe?.medicamentName = medicamentName.text!
            recipe?.medicamentType = medicamentType.text!
            CoreDataManager.instance.saveContext()
        }
        
//        recipe?.medicamentName = medicamentName.text!
//        recipe?.medicamentType = medicamentType.text!
//        recipe?.periodCourse = Int16(periodCourseSlider.value)
//        recipe?.mealCheck = mealSwitch.isOn
//        recipe?.mealTime = Int16(mealSegContol.titleForSegment(at: mealSegContol.selectedSegmentIndex)!)!
//        recipe?.timesDay = Int16(timesDaySegControl.titleForSegment(at: timesDaySegControl.selectedSegmentIndex)!)!
//        
//        CoreDataManager.instance.saveContext()
//        print("Save! \(recipe)")
    }
    
//MARK: viewControllerDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerClock), userInfo: nil, repeats: true)
        
        //Notifications addObserver
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //Notifications removeObserver
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
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
    
    func textFieldCheckEmpty() -> Bool {
        if (medicamentName.text?.isEmpty)! {
            errorAlertAction(title: "Error!", message: "Enter medicament name!")
            return false
        }
        if (medicamentType.text?.isEmpty)! {
            errorAlertAction(title: "Error!", message: "Enter medicament type!")
            return false
        }
        return true
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
//MARK: - ErrorActionsDelegate
    func errorAlertAction(title: String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
//MARK: - Timer
    func timerClock() {
        let date = Date()
        let dateFormatter = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .medium)
        timeClockLabel.text = dateFormatter
    }
    
//MARK: - segue
    func prepareForSegue(segue: UIStoryboardSegue, sender: SBRecipe?) {
        if segue.identifier == SBRecipesListController.segueIdentifierAddToList {
            _ = segue.destination as! SBAddRecipeController
        }
        if segue.identifier == SBRecipesListController.segueIdentifierRecipeInfo {
            
        }
    }
}


//
//  SBAddVC.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 27.11.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import UIKit

class SBAddVC: UIViewController {
    
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
    
//MARK: - Actions
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func periodSliderAction(_ sender: UISlider) {
        let temp : Int = Int(periodCourseSlider.value)
        periodCourseLabel.text = temp.description
    }
    
    
    func timerClock() -> Void {
        let date = Date()
        let dateFormatter = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .medium)
        timeClockLabel.text = dateFormatter
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
            errorAlertAction(message: "Enter medicament name!")
            return false
        }
        if (medicamentType.text?.isEmpty)! {
            errorAlertAction(message: "Enter medicament type!")
            return false
        }
        return true
    }
    
//MARK: - ErrorActionsDelegate
    func errorAlertAction(message:String) -> Void {
        let alertController = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
//MARK: viewControllerDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerClock), userInfo: nil, repeats: true)
    }
    
}

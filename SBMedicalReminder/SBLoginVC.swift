//
//  SBLoginVC.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 27.11.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import UIKit

class SBLoginVC: UIViewController, UITextFieldDelegate {
    
    let keys = SBKeysAndSegue()
    let segueKeys = SBKeysAndSegue()
    let alert = SBAlertManager()
    
//MARK: - IBOutlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
//MARK: viewControllerDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//MARK: - Actions
    @IBAction func loginUserAction(_ sender: UIButton) {
        if loginUser() {
            
        }
    }
    
    func loginUser() -> Bool {
        let userInfo = UserDefaults.standard
        let userName = userInfo.string(forKey: keys.kUserName)
        let userPassword = userInfo.string(forKey: keys.kUserPassword)
        
        if textFieldIsEmpty() == false {
            if (userNameTextField.text == userName) || (userPasswordTextField.text == userPassword) {
                return true
            } else {
                alert.errorAlertAction(message: "Incorrect user name or password!")
                userNameTextField.text = ""
                userPasswordTextField.text = ""
                return false
            }
        }
        return false
    }
    
//MARK: - TextFieldDelegate
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        if textField == userNameTextField {
            userPasswordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldIsEmpty() -> Bool {
        guard userNameTextField.text?.isEmpty == false else {
            alert.errorAlertAction(message: "Enter user name!")
            return true
        }
        guard userPasswordTextField.text?.isEmpty == false else {
            alert.errorAlertAction(message: "Enter user password!")
            return true
        }
        return false
    }
    
//MARK: - segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueKeys.segueIdentifireTableToAdd {
            _ = segue.destination as! SBAddRecipeController
        }
        if segue.identifier == segueKeys.segueIdentifierRecipeInfo {
            let controller = segue.destination as! SBRecipeInfoController
            let recipeInfo = sender as! SBManagedRecipe
            controller.recipeInfo = recipeInfo
        }
    }
    
}

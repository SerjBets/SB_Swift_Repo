//
//  SBForgotPasswordVC.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 27.11.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import UIKit

class SBForgotPasswordVC: UIViewController, UITextFieldDelegate {
//MARK: - keys
    
    let keys = SBKeysAndSegue()
    let alert = SBAlertManager()
    
//MARK: - IBOutlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    
//MARK: viewController
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//MARK: - Actions
    @IBAction func resetAction(_ sender: UIButton) {
        resetUserPassword()
    }
    
    func resetUserPassword() {
        let userInfo = UserDefaults.standard
        let userName = userInfo.string(forKey: keys.kUserName)
        let userEmail = userInfo.string(forKey: keys.kUserEmail)
        if textFieldIsEmpty() {
            if (userNameTextField.text == userName) && (userEmailTextField.text == userEmail) {
                let userPassword = userInfo.string(forKey: keys.kUserPassword)
                alert.errorAlertAction(message:"Your password is \(userPassword!) !")
            } else {
                alert.errorAlertAction(message:"Incorrect user name or password!")
                userEmailTextField.text = ""
                userEmailTextField.text = ""
            }
        }
    }
    
//MARK: - TextFieldDelegate
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        if textField == userNameTextField {
            userEmailTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldIsEmpty() -> Bool {
        if (userNameTextField.text?.isEmpty)! {
            alert.errorAlertAction(message: "Enter user name!")
            return false
        }
        if (userEmailTextField.text?.isEmpty)! {
            alert.errorAlertAction(message: "Enter user password!")
            return false
        }
        return true
    }

}

//
//  SBRegisterVC.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 27.11.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import UIKit

class SBRegisterVC: UIViewController, UITextFieldDelegate, UIAlertViewDelegate {
    
    let alert = SBAlertManager()
    let registerKeys = SBKeysAndSegue()
    
//MARK: - IBOutlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    
//MARK: viewController
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//MARK: - Actions
    @IBAction func registerUserAction(_ sender: UIButton) {
        registerUser()
    }

    func registerUser() {
        let userInfo = UserDefaults.standard;
        if self.textFieldIsEmpty() == false {
            userInfo.set(userNameTextField.text,           forKey: registerKeys.kUserName)
            userInfo.set(userPasswordTextField.text,       forKey: registerKeys.kUserPassword)
            userInfo.set(confirmPasswordTextField.text,    forKey: registerKeys.kConfirmPassword)
            userInfo.set(userEmailTextField.text,          forKey: registerKeys.kUserEmail)
            alert.errorAlertDismissAction(message: "New user successful registered!")
            userInfo.synchronize()
        }
    }

//MARK: - TextFieldDelegate
    func textFieldIsEmpty() -> Bool {
        guard userNameTextField.text?.isEmpty == false else {
            alert.errorAlertAction(message: "Enter user name!")
            return true
        }
        guard userPasswordTextField.text?.isEmpty == false else {
            alert.errorAlertAction(message: "Enter user password!")
            return true
        }
        guard confirmPasswordTextField.text?.isEmpty == false else {
            alert.errorAlertAction(message: "Confirm password!")
            return true
        }
        guard userEmailTextField.text?.isEmpty == false else {
            alert.errorAlertAction(message: "Enter user e-mail!")
            return true
        }
        if (userPasswordTextField.text != confirmPasswordTextField.text) {
            alert.errorAlertAction(message: "Passwords do not match! Check you passwords!")
            return true
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            userPasswordTextField.becomeFirstResponder()
        } else if textField == userPasswordTextField {
            confirmPasswordTextField.becomeFirstResponder()
        } else if textField == confirmPasswordTextField {
            userEmailTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

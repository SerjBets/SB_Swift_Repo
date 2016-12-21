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
    let keys = SBKeysAndSegue()
    
//MARK: - IBOutlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
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
            userInfo.set(userNameTextField.text,           forKey: keys.kUserName)
            userInfo.set(userPasswordTextField.text,       forKey: keys.kUserPassword)
            userInfo.set(confirmPasswordTextField.text,    forKey: keys.kConfirmPassword)
            userInfo.set(userEmailTextField.text,          forKey: keys.kUserEmail)
            alert.showAlertWithDismissController(controller: self, message: "New user successful registered!")
            userInfo.synchronize()
        }
    }

//MARK: - TextFieldDelegate
    func textFieldIsEmpty() -> Bool {
        guard userNameTextField.text?.isEmpty == false else {
            alert.showAlertFromController(controller: self, message: "Enter user name!")
            return true
        }
        guard userPasswordTextField.text?.isEmpty == false else {
            alert.showAlertFromController(controller: self, message: "Enter user password!")
            return true
        }
        guard confirmPasswordTextField.text?.isEmpty == false else {
            alert.showAlertFromController(controller: self, message: "Confirm password!")
            return true
        }
        guard userEmailTextField.text?.isEmpty == false else {
            alert.showAlertFromController(controller: self, message: "Enter user e-mail!")
            return true
        }
        if (userPasswordTextField.text != confirmPasswordTextField.text) {
            alert.showAlertFromController(controller: self, message: "Passwords do not match! Check you passwords!")
            return true
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint.init(x: 0, y: 100), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
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

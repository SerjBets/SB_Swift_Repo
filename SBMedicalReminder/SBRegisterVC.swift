//
//  SBRegisterVC.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 27.11.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import UIKit

class SBRegisterVC: UIViewController, UITextFieldDelegate, UIAlertViewDelegate {
//MARK: - keys
    let kUserName = "userName"
    let kUserPassword = "userPassword"
    let kConfirmPassword = "confirmPassword"
    let kUserEmail = "userEmail"
    
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
        if self.textFieldCheck() {
            userInfo.set(userNameTextField.text,           forKey: kUserName)
            userInfo.set(userPasswordTextField.text,       forKey: kUserPassword)
            userInfo.set(confirmPasswordTextField.text,    forKey: kConfirmPassword)
            userInfo.set(userEmailTextField.text,          forKey: kUserEmail)
            let alertController = UIAlertController(title: "Error!", message: "New user successful registered!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                self.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion:nil)
            userInfo.synchronize()
        }
    }

//MARK: - TextFieldDelegate
    func textFieldCheck() -> Bool {
        guard userNameTextField.text?.isEmpty == false else {
            errorAlertAction(message: "Enter user name!")
            return false
        }
        guard userPasswordTextField.text?.isEmpty == false else {
            errorAlertAction(message: "Enter user password!")
            return false
        }
        guard confirmPasswordTextField.text?.isEmpty == false else {
            errorAlertAction(message: "Confirm password!")
            return false
        }
        guard userEmailTextField.text?.isEmpty == false else {
            errorAlertAction(message: "Enter user e-mail!")
            return false
        }
        if (userPasswordTextField.text != confirmPasswordTextField.text) {
            errorAlertAction(message: "Passwords do not match! Check you passwords!")
            return false
        }
        return true
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
    
//MARK: - ErrorActionsDelegate
    func errorAlertAction(message:String) {
        let alertController = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion:nil)
    }

}

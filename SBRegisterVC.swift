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
    let kuserEmail = "userEmail"
    
//MARK: - IBOutlets
    @IBOutlet weak var userNameTextField: UITextField! { didSet { userNameTextField.delegate = self } }
    
    @IBOutlet weak var userPasswordTextField: UITextField! { didSet { userPasswordTextField.delegate = self } }
    
    @IBOutlet weak var confirmPasswordTextField: UITextField! { didSet { confirmPasswordTextField.delegate = self } }
    
    @IBOutlet weak var userEmailTextField: UITextField! { didSet { userEmailTextField.delegate = self } }
    
//MARK: - Actions
    @IBAction func registerUserAction(_ sender: UIButton) {
        self.registerUser()
    }
    
    func registerUser() -> Void {
        let userInfo = UserDefaults.standard;
        if self.textFieldCheckEmpty() {
            userInfo.set(self.userNameTextField.text,           forKey: kUserName)
            userInfo.set(self.userPasswordTextField.text,       forKey: kUserPassword)
            userInfo.set(self.confirmPasswordTextField.text,    forKey: kConfirmPassword)
            userInfo.set(self.userEmailTextField.text,          forKey: kuserEmail)
        }
        userInfo.synchronize()
    }
    
//MARK: - TextFieldDelegate
    func textFieldCheckEmpty() -> Bool {
        if (self.userNameTextField.text?.isEmpty)! {
            self.errorAlertAction(message: "Enter user name!")
            return false
        }
        if (self.userPasswordTextField.text?.isEmpty)! {
            self.errorAlertAction(message: "Enter user password!")
            return false
        }
        if (self.confirmPasswordTextField.text?.isEmpty)! {
            self.errorAlertAction(message: "Confirm password!")
            return false
        }
        if (self.userEmailTextField.text?.isEmpty)! {
            self.errorAlertAction(message: "Enter user e-mail!")
        }
        if (self.userPasswordTextField.text != self.confirmPasswordTextField.text) {
            self.errorAlertAction(message: "Passwords do not match! Check you passwords!")
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        if textField == self.userNameTextField {
            self.userPasswordTextField.becomeFirstResponder()
        } else if textField == self.userPasswordTextField {
            self.confirmPasswordTextField.becomeFirstResponder()
        } else if textField == self.confirmPasswordTextField {
            self.userEmailTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
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
        userEmailTextField.delegate = self
        userPasswordTextField.delegate = self
    }
}

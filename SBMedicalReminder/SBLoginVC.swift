//
//  SBLoginVC.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 27.11.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import UIKit

class SBLoginVC: UIViewController, UITextFieldDelegate, UIAlertViewDelegate {
//MARK: - keys
    let kUserName = "userName"
    let kUserPassword = "userPassword"
    
//MARK: - IBOutlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
//MARK: viewControllerDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//MARK: - Actions
    @IBAction func loginUserAction(_ sender: UIButton) {
        loginUser()
    }
    
    func loginUser() {
        let userInfo = UserDefaults.standard
        let userName = userInfo.string(forKey: kUserName)
        let userPassword = userInfo.string(forKey: kUserPassword)
        
        if textFieldCheck() {
            if (userNameTextField.text == userName) || (userPasswordTextField.text == userPassword) {
                
            } else {
                errorAlertAction(message: "Incorrect user name or password!")
                userNameTextField.text = ""
                userPasswordTextField.text = ""
            }
        }
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
    
    func textFieldCheck() -> Bool {
        guard userNameTextField.text?.isEmpty == false else {
            errorAlertAction(message: "Enter user name!")
            return false
        }
        guard userPasswordTextField.text?.isEmpty == false else {
            errorAlertAction(message: "Enter user password!")
            return false
        }
        return true
    }
    
//MARK: - ErrorActionsDelegate
    func errorAlertAction(message:String) {
        let alertController = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

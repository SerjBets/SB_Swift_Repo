//
//  SBForgotPasswordVC.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 27.11.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import UIKit

class SBForgotPasswordVC: UIViewController {
//MARK: - keys
    let kUserName = "userName"
    let kUserPassword = "userPassword"
    let kUserEmail = "userEmail"
    
//MARK: - IBOutlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    
//MARK: - Actions
    @IBAction func resetAction(_ sender: UIButton) {
        resetUserPassword()
    }
    
    func resetUserPassword() {
        let userInfo = UserDefaults.standard
        let userName = userInfo.string(forKey: kUserName)
        let userEmail = userInfo.string(forKey: kUserEmail)
        if textFieldCheckEmpty() {
            if (userNameTextField.text == userName) && (userEmailTextField.text == userEmail) {
                let userPassword = userInfo.string(forKey: kUserPassword)
                errorAlertAction(message:"Your password is \(userPassword!) !")
            } else {
                errorAlertAction(message:"Incorrect user name or password!")
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
    
    func textFieldCheckEmpty() -> Bool {
        if (userNameTextField.text?.isEmpty)! {
            errorAlertAction(message: "Enter user name!")
            return false
        }
        if (userEmailTextField.text?.isEmpty)! {
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
    
//MARK: viewControllerDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

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
    @IBOutlet weak var scrollView: UIScrollView!
    
//MARK: viewController
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//MARK: - Actions
    @IBAction func resetAction(_ sender: UIButton) {
        
        if resetUserPassword() == true {
            performSegue(withIdentifier: keys.segueForgotPasswordToLogin, sender: nil)
        }
    }
    
    func resetUserPassword() -> Bool {
        let userInfo = UserDefaults.standard
        let userName = userInfo.string(forKey: keys.kUserName)
        let userEmail = userInfo.string(forKey: keys.kUserEmail)
        if textFieldIsEmpty() == false {
            if (userNameTextField.text == userName) && (userEmailTextField.text == userEmail) {
                let userPassword = userInfo.string(forKey: keys.kUserPassword)
                alert.showAlertFromController(controller: self, message:"Your password is \(userPassword!) !")
                return true
            } else {
                alert.showAlertFromController(controller: self, message:"Incorrect user name or password!")
                userEmailTextField.text = ""
                userEmailTextField.text = ""
            }
        }
        return false
    }
    
//MARK: - TextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint.init(x: 0, y: 100), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        if textField == userNameTextField {
            userEmailTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldIsEmpty() -> Bool {
        guard userNameTextField.text?.isEmpty == false else {
            alert.showAlertFromController(controller: self, message: "Enter user name!")
            return true
        }
        guard userEmailTextField.text?.isEmpty == false else {
            alert.showAlertFromController(controller: self, message: "Enter user password!")
            return true
        }
        return false
    }
    
//MARK: - segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == keys.segueForgotPasswordToLogin {
            _ = segue.destination as! SBLoginVC
        }
    }
}

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
    @IBOutlet weak var userNameTextField: UITextField! { didSet { userNameTextField.delegate = self } }
    @IBOutlet weak var userPasswordTextField: UITextField! { didSet { userPasswordTextField.delegate = self } }
    @IBOutlet weak var confirmPasswordTextField: UITextField! { didSet { confirmPasswordTextField.delegate = self } }
    @IBOutlet weak var userEmailTextField: UITextField! { didSet { userEmailTextField.delegate = self } }
    
//MARK: - Actions
    @IBAction func registerUserAction(_ sender: UIButton) {
        registerUser()
    }
    
    func registerUser() {
        let userInfo = UserDefaults.standard;
        if self.textFieldCheckEmpty() {
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
    func textFieldCheckEmpty() -> Bool {
        if (userNameTextField.text?.isEmpty)! {
            errorAlertAction(message: "Enter user name!")
            return false
        }
        if (userPasswordTextField.text?.isEmpty)! {
            errorAlertAction(message: "Enter user password!")
            return false
        }
        if (confirmPasswordTextField.text?.isEmpty)! {
            errorAlertAction(message: "Confirm password!")
            return false
        }
        if (userEmailTextField.text?.isEmpty)! {
            errorAlertAction(message: "Enter user e-mail!")
        }
        if (userPasswordTextField.text != confirmPasswordTextField.text) {
            errorAlertAction(message: "Passwords do not match! Check you passwords!")
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
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
    
//MARK: viewControllerDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        userEmailTextField.delegate = self
        userPasswordTextField.delegate = self
        
        //Notifications addObserver
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //Notifications removeObserver
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
}

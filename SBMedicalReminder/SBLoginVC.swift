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
    @IBOutlet weak var userNameTextField: UITextField! { didSet { userNameTextField.delegate = self } }
    @IBOutlet weak var userPasswordTextField: UITextField! { didSet { userPasswordTextField.delegate = self } }
    
//MARK: - Actions
    @IBAction func loginUserAction(_ sender: UIButton) {
        loginUser()
    }
    
    func userAccountCheck() -> Bool {
        let userInfo = UserDefaults.standard
        let userName = userInfo.string(forKey: kUserName)
        if userName == nil {
            return false
        }
        return true
    }
    
    func loginUser() {
        let userInfo = UserDefaults.standard
        let userName = userInfo.string(forKey: kUserName)
        let userPassword = userInfo.string(forKey: kUserPassword)
        
        if textFieldCheckEmpty() {
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
    
    func textFieldCheckEmpty() -> Bool {
        if (userNameTextField.text?.isEmpty)! {
            errorAlertAction(message: "Enter user name!")
            return false
        }
        if (userPasswordTextField.text?.isEmpty)! {
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
        
        //Notifications addObserver
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //Notifications removeObserver
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    override func viewWillLayoutSubviews() {
        if userAccountCheck() {
            let mainVC = storyboard?.instantiateViewController(withIdentifier: "SBNavigationVC")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = mainVC
        }
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

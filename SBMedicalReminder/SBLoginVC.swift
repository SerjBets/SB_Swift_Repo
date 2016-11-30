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
    let kUserName = "userName";
    let kUserPassword = "userPassword";
    
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
    
    func loginUser() -> Void {
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
    func errorAlertAction(message:String) -> Void {
        let alertController = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
//MARK: viewControllerDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        if userAccountCheck() {
            let mainVC = storyboard?.instantiateViewController(withIdentifier: "SBNavigationVC")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = mainVC
        }
    }
}

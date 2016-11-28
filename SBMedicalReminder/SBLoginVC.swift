//
//  SBLoginVC.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 27.11.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import UIKit

class SBLoginVC: UIViewController {
//keys
    let kUserName = "userName";
    let kUserPassword = "userPassword";
    
//IBOutlets
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginActionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func loginUser() -> Void {
        let userInfo = UserDefaults.standard;
        userInfo.set(self.userNameTextField.text, forKey: kUserName);
        
    }
}

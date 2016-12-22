//
//  SBKeysAndSegue.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 20.12.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import Foundation

class SBKeysAndSegue {

//MARK: - Login / Register user keys
    let kUserName = "userName"
    let kUserPassword = "userPassword"
    let kConfirmPassword = "confirmPassword"
    let kUserEmail = "userEmail"
    
//MARK: - Segue
    
    //from LoginViewController
    let segueLoginToRecipesTable        = "segueLoginToRecipesTable"
    let segueLoginToRegister            = "segueLoginToRegister"
    let segueLoginToForgotPassword      = "segueLoginToForgotPassword"
    
    //from RegisterViewController
    let segueRegisterToLogin            = "segueRegisterToLogin"
    
    //from ForgotPasswordToLogin
    let segueForgotPasswordToLogin      = "segueForgotPasswordToLogin"
    
    //from RecipesTableViewController
    let segueRecipeTableToRecipeInfo    = "segueRecipeTableToRecipeInfo"
    let segueRecipesTableToAdd          = "segueRecipesTableToAdd"
    
    //from AddRecipeViewController
    let segueAddToRecipesTable          = "segueAddToRecipesTable"
    
}

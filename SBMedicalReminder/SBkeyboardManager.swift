//
//  SBkeyboardManager.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 06.12.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import Foundation
import UIKit

class SBkeyboardManager {

    func keyboardWillShow(notification: NSNotification, view: UIView) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification, view: UIView) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y != 0 {
                view.frame.origin.y += keyboardSize.height
            }
        }
    }
}

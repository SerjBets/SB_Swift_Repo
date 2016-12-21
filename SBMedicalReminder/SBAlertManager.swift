//
//  SBAlertManager.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 20.12.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import Foundation
import UIKit

class SBAlertManager: UIAlertController, UIAlertViewDelegate {
    
    func showAlertFromController(controller: UIViewController, message:String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        controller.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithDismissController(controller: UIViewController, message:String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        controller.present(alert, animated: true, completion: nil)
    }

}

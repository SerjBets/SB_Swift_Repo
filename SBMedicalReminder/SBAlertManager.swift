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
    
    func errorAlertAction(message:String) {
        let alertController = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func errorAlertDismissAction(message:String) {
        let alertController = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion:nil)
    }

}

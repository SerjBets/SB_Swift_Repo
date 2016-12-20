//
//  SBConfigureCell.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 19.12.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import Foundation
import UIKit

class SBConfigureCell: UITableViewCell {
    
    func configureCell(recipe: SBManagedRecipe, days: Int) {
        textLabel?.text = recipe.medicamentName
        detailTextLabel?.text = String("\(days) days")
    }
}

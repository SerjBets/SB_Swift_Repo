//
//  SBMainVC.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 27.11.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import UIKit
import CoreData

class SBMainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
//MARK: - IBOutlets
    @IBOutlet weak var recipeTableView: UITableView!
    
    var tempRecipeObj : SBRecipeClass?
    
//MARK: - Actions
    @IBAction func editTableAction(_ sender: UIBarButtonItem) {
        //fetchRequest()
        //recipeTableView.isEditing = true
    }
    
//MARK: - CoreDataDelegate
    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "SBRecipeEntity", keyForSort: "medicamentName")
    
//MARK - TableViewDataSourse
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe = fetchedResultsController.object(at: indexPath) as! SBRecipeClass
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = recipe.medicamentName
        
        return cell!
    }
    
//MARK: viewControllerDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }
}

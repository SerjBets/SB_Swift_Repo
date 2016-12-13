//
//  SBRecipesListController.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 27.11.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import UIKit
import CoreData

class SBRecipesListController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    static let cellReuseIdentifier = "RecipeCell"
    static let segueIdentifireListToAdd = "sequeListToAdd"
    static let segueIdentifierRecipeInfo = "segueRecipeInfo"
    static let segueIdentifierAddToList = "segueAddToList"
    
    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "SBRecipe", keyForSort: SBRecipe.kMedicamentName)
    
//MARK: - IBOutlets
    @IBOutlet weak var recipeTableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
//MARK: - Actions
    @IBAction func addAction(_ sender: Any) {
        performSegue(withIdentifier: SBRecipesListController.segueIdentifierAddToList, sender: nil)
    }
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        if recipeTableView.isEditing {
            recipeTableView.isEditing = false;
            editButton.style = UIBarButtonItemStyle.plain;
            editButton.title = "Edit"
        } else {
            recipeTableView.isEditing = true
            editButton.style =  UIBarButtonItemStyle.done;
            editButton.title = "Done"
        }
    }
    
//MARK - TableViewDataSourse
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rows = fetchedResultsController.sections {
            return rows[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = recipeTableView.dequeueReusableCell(withIdentifier: SBRecipesListController.cellReuseIdentifier)
        if (cell == nil) {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: SBRecipesListController.cellReuseIdentifier)
        }
        let recipe = fetchedResultsController.object(at: indexPath) as! SBRecipe
        cell?.textLabel?.text = recipe.medicamentName
        cell?.detailTextLabel?.text = recipe.medicamentType
        return cell!
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        recipeTableView.reloadData()
    }
    
//MARK: viewControllers
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }
    
//MARK: - segue
    func prepareForSegue(segue: UIStoryboardSegue, sender: SBRecipe?) {
        if segue.identifier == SBRecipesListController.segueIdentifireListToAdd {
            _ = segue.destination as! SBAddRecipeController
        }
        if segue.identifier == SBRecipesListController.segueIdentifierRecipeInfo {
            
        }
    }
}


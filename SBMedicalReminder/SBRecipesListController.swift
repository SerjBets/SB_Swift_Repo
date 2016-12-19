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
    
    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "SBRecipe", keyForSort: SBManagedRecipe.kMedicamentName)
    
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
    
    //Read CoreData to TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = recipeTableView.dequeueReusableCell(withIdentifier: SBRecipesListController.cellReuseIdentifier)
        if (cell == nil) {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: SBRecipesListController.cellReuseIdentifier)
        }
        let recipe = fetchedResultsController.object(at: indexPath) as! SBManagedRecipe
        var date = 0
        if recipe.date != nil {
            date = daysBetweenDates(startDate: Date(), endDate: recipe.date!)
        }
        cell?.textLabel?.text = recipe.medicamentName
        cell?.detailTextLabel?.text = String("\(date) days")
        return cell!
    }
    
    //Select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = fetchedResultsController.object(at: indexPath) as! SBManagedRecipe
        performSegue(withIdentifier: SBRecipesListController.segueIdentifierRecipeInfo, sender: recipe)
    }
    
    //Delete row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let recipe = fetchedResultsController.object(at: indexPath) as! SBManagedRecipe
            CoreDataManager.instance.managedObjectContext.delete(recipe)
            CoreDataManager.instance.saveContext()
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        recipeTableView.reloadData()
    }
    
    //Calculate how many days between 2 dates
    func daysBetweenDates(startDate: Date, endDate: Date) -> Int
    {
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.day], from: startDate, to: endDate)
        return components.day!
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SBRecipesListController.segueIdentifireListToAdd {
            _ = segue.destination as! SBAddRecipeController
        }
        if segue.identifier == SBRecipesListController.segueIdentifierRecipeInfo {
            let controller = segue.destination as! SBRecipeInfoController
            let recipeInfo = sender as! SBManagedRecipe
            controller.recipeInfo = recipeInfo
        }
    }
}


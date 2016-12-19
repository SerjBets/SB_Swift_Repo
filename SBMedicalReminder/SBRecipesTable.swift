//
//  SBRecipesTable.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 19.12.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import CoreData
import UIKit

class SBRecipesTable: UITableViewController, NSFetchedResultsControllerDelegate {
    
    static let cellReuseIdentifier = "RecipeCell"
    static let segueIdentifireTableToAdd = "segueTableToAdd"
    static let segueIdentifierRecipeInfo = "segueTableRecipeInfo"
    static let segueIdentifierAddToTable = "segueAddToTable"
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "SBRecipe", keyForSort: SBManagedRecipe.kMedicamentName)
    
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
    
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.isEditing = false;
            editButton.style = UIBarButtonItemStyle.plain;
            editButton.title = "Edit"
        } else {
            tableView.isEditing = true
            editButton.style =  UIBarButtonItemStyle.done;
            editButton.title = "Done"
        }
    }
    
    @IBAction func addAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: SBRecipesTable.segueIdentifierAddToTable, sender: nil)
    }
    
//MARK - TableViewDataSourse
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rows = fetchedResultsController.sections {
            return rows[section].numberOfObjects
        } else {
            return 0
        }
    }
    
//Read CoreData to TableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: SBRecipesTable.cellReuseIdentifier)
        if (cell == nil) {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: SBRecipesTable.cellReuseIdentifier)
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = fetchedResultsController.object(at: indexPath) as! SBManagedRecipe
        performSegue(withIdentifier: SBRecipesTable.segueIdentifierRecipeInfo, sender: recipe)
    }
    
//Delete row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let recipe = fetchedResultsController.object(at: indexPath) as! SBManagedRecipe
            CoreDataManager.instance.managedObjectContext.delete(recipe)
            CoreDataManager.instance.saveContext()
        default: break
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    func daysBetweenDates(startDate: Date, endDate: Date) -> Int
    {
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.day], from: startDate, to: endDate)
        return components.day!
    }
    
//MARK: - segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SBRecipesTable.segueIdentifireTableToAdd {
            _ = segue.destination as! SBAddRecipeController
        }
        if segue.identifier == SBRecipesTable.segueIdentifierRecipeInfo {
            let controller = segue.destination as! SBRecipeInfoController
            let recipeInfo = sender as! SBManagedRecipe
            controller.recipeInfo = recipeInfo
        }
    }
}

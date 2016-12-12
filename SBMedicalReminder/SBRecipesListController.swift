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
    
    typealias Select = (SBRecipe?) -> ()
    var didSelect: Select?
    
    static let cellReuseIdentifier = "RecipeCell"
    static let segueIdentifireListToAdd = "sequeListToAdd"
    static let segueIdentifierRecipeInfo = "segueRecipeInfo"
    static let segueIdentifierAddToList = "segueAddToList"
    
    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "SBRecipe", keyForSort: SBRecipe.kMedicamentName)
    
//MARK: - IBOutlets
    @IBOutlet weak var recipeTableView: UITableView!
    
//MARK: - Actions
    @IBAction func addAction(_ sender: Any) {
        performSegue(withIdentifier: SBRecipesListController.segueIdentifierAddToList, sender: nil)
    }
    
    
//MARK - TableViewDataSourse
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rows = fetchedResultsController.sections {
            return rows[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let managedObject = fetchedResultsController.object(at: indexPath) as! NSManagedObject
            CoreDataManager.instance.managedObjectContext.delete(managedObject)
            CoreDataManager.instance.saveContext()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: SBRecipesListController.cellReuseIdentifier)
        if (cell == nil) {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: SBRecipesListController.cellReuseIdentifier)
        }
        configureCell(cell: cell!, atIndexPath: indexPath as NSIndexPath)
        return cell!
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let recipe = fetchedResultsController.object(at: indexPath as IndexPath) as! SBRecipe
        cell.textLabel?.text = recipe.medicamentName
        //cell!.textLabel!.text = recipe.value(forKey: SBRecipe.kMedicamentName) as? String
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = fetchedResultsController.object(at: indexPath as IndexPath) as! SBRecipe
        if let dSelect = self.didSelect {
            dSelect(recipe)
            dismiss(animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: SBRecipesListController.segueIdentifierRecipeInfo, sender: recipe)
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch(type) {
        case .insert:
            if let newIndexPath = newIndexPath {
                recipeTableView.insertRows(at: [newIndexPath as IndexPath], with:UITableViewRowAnimation.fade)
            }
        case .delete:
            if let indexPath = indexPath {
                recipeTableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
            }
        case .update:
            if let indexPath = indexPath {
                if let cell = recipeTableView.cellForRow(at: indexPath as IndexPath) {
                    configureCell(cell: cell, atIndexPath: indexPath as NSIndexPath)
                }
            }
        case .move:
            if let indexPath = indexPath {
                if let newIndexPath = newIndexPath {
                    recipeTableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
                    recipeTableView.insertRows(at: [newIndexPath as IndexPath], with: UITableViewRowAnimation.fade)
                }
            }
        }
        recipeTableView.reloadData()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        recipeTableView.endUpdates()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        recipeTableView.beginUpdates()
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
            let controller = segue.destination as! SBAddRecipeController
            controller.recipe = sender
        }
        if segue.identifier == SBRecipesListController.segueIdentifierRecipeInfo {
            
        }
    }
}

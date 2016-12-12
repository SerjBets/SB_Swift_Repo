//
//  SBMainVC.swift
//  SBMedicalReminder
//
//  Created by Сергей Бец on 27.11.16.
//  Copyright © 2016 Сергей Бец. All rights reserved.
//

import UIKit
import CoreData

class SBMainVC: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    typealias Select = (SBRecipe?) -> ()
    
    var didSelect: Select?
    var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "SBRecipe", keyForSort: SBRecipe.kMedicamentName)
    
//MARK: - IBOutlets
    @IBOutlet weak var recipeTableView: UITableView!
    
//MARK: - Actions
    @IBAction func addAction(_ sender: Any) {
        performSegue(withIdentifier: "sequeMainToAdd", sender: nil)
    }
    
    
//MARK - TableViewDataSourse
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe = fetchedResultsController.object(at: indexPath) as! NSManagedObject
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if (cell == nil) {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: "Cell")
        }
        cell!.textLabel!.text = recipe.value(forKey: SBRecipe.kMedicamentName) as? String
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let managedObject = fetchedResultsController.object(at: indexPath) as! NSManagedObject
            CoreDataManager.instance.managedObjectContext.delete(managedObject)
            CoreDataManager.instance.saveContext()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = fetchedResultsController.object(at: indexPath) as? SBRecipe
        if let dSelect = self.didSelect {
            dSelect(recipe)
            dismiss(animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "segueRecipeInfo", sender: recipe)
        }
    }
    
////MARK: - Fetched Results Controller Delegate
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if recipeTableView != nil {
            recipeTableView.beginUpdates()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                recipeTableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                let recipe = fetchedResultsController.object(at: indexPath) as! SBRecipe
                let cell = recipeTableView.cellForRow(at: indexPath)
                cell!.textLabel?.text = recipe.medicamentName
            }
        case .move:
            if let indexPath = indexPath {
                recipeTableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let newIndexPath = newIndexPath {
                recipeTableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                recipeTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        recipeTableView.endUpdates()
    }
    
//MARK: viewControllers
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTableView = UITableView();
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }
    
//MARK: - segue
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "sequeMainToAdd" {
            let controller = segue.destination as! SBAddVC
            controller.recipe = (sender as? SBRecipe)!
        }
    }
}

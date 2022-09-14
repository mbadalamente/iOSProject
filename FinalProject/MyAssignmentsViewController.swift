//
//  MyAssignmentsViewController.swift
//  FinalProject
//
//  Created by Madison Badalamente on 5/7/22.
//

import UIKit
import CoreData

class MyAssignmentsViewController: UIViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: using core data
    lazy var fetchedResultsController: NSFetchedResultsController<ManagedAssignment> = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ManagedAssignment> = ManagedAssignment.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor (key: "assignmentName", ascending: true)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            try fetchedResultsController.performFetch()
        } catch {
           let fetchError = error as NSError
           // print("\(fetchError), \(fetchError.localizedDescription)")
        }
    }
    
    // MARK: sending core data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "fromListToViewAssignment"{
            print("SEGUE: Moving from list to views")
            let destinationVC = segue.destination as! ViewAssignmentViewController
            if tableView.indexPathForSelectedRow!.row >= 0 {
                print("table view row was passed")
                let selectedManagedAssignment: ManagedAssignment = fetchedResultsController.object(at: tableView.indexPathForSelectedRow!)
                destinationVC.assignmentName = selectedManagedAssignment.assignmentName!
            }
        }
    }
    
}

// MARK: table view
extension MyAssignmentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ManagedAssignmentTableViewCell.reuseIdentifier, for: indexPath) as? ManagedAssignmentTableViewCell else {
            fatalError("Unexpected Index Path")
        }
        
        let managedAssignment = fetchedResultsController.object(at: indexPath)
        cell.assignmentNameLabel.text = managedAssignment.assignmentName
        cell.assignmentTypeLabel.text = managedAssignment.assignmentType
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let managedAssignments = fetchedResultsController.fetchedObjects else { return 0 }
        return managedAssignments.count
    }
}




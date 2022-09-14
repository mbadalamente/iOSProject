//
//  AddAssignmentViewController.swift
//  FinalProject
//
//  Created by Madison Badalamente on 4/13/22.
//

import UIKit
import CoreData

class AddAssignmentViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var courseTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var urgencyControl: UISegmentedControl!
    let myAssignment: Assignment = Assignment()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        nameTextField.delegate = self;

    }
    @IBAction func urgencyChanged(_ sender: Any) {
        switch urgencyControl.selectedSegmentIndex
            {
            case 0:
                myAssignment.AssignmentImportance = "Yes"
            case 1:
                myAssignment.AssignmentImportance = "No"
            default:
                break
            }
    }
    
    @IBAction func datePicker(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        myAssignment.AssignmentDueDate = dueDatePicker.date
    }
    @IBAction func addAssignment(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let managedAssignment = NSEntityDescription.entity(forEntityName: "ManagedAssignment", in: managedContext)
        let myNewManagedAssignment = NSManagedObject(entity: managedAssignment!, insertInto: managedContext)
        
        myNewManagedAssignment.setValue(nameTextField.text!, forKey: "assignmentName")
        myNewManagedAssignment.setValue(typeTextField.text!, forKey: "assignmentType")
        myNewManagedAssignment.setValue(courseTextField.text!, forKey: "assignmentCourseName")
        myNewManagedAssignment.setValue(myAssignment.AssignmentImportance, forKey: "assignmentUrgency")
        myNewManagedAssignment.setValue(myAssignment.AssignmentDueDate, forKey: "assignmentDate")
        
        do{
            try managedContext.save()
        } catch {
           // print("error saving to core data")
        }
    }
}

extension AddAssignmentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

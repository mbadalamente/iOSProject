//
//  ViewAssignmentViewController.swift
//  FinalProject
//
//  Created by Madison Badalamente on 5/7/22.
//

import UIKit
import CoreData
import EventKit

class ViewAssignmentViewController: UIViewController,NSFetchedResultsControllerDelegate {
    var assignmentName: String = ""
    var arrayLocation: Int = 0
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var dueDate: Date = Date()

    // MARK: core data usage
    lazy var fetchedResultsController: NSFetchedResultsController<ManagedAssignment> = {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ManagedAssignment> = ManagedAssignment.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor (key: "assignmentName", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "assignmentName == %@", assignmentName)
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()

    @IBOutlet weak var assignmentNameLabel: UILabel!
    @IBOutlet weak var assignmentTypeLabel: UILabel!
    @IBOutlet weak var urgencyLabel: UILabel!
    @IBOutlet weak var assignmentDueDateLabel: UILabel!
    @IBOutlet weak var assignmentCourse: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try fetchedResultsController.performFetch()
            loadViewWithManagedData()
            print("Number of assignments returned: \(fetchedResultsController.fetchedObjects!.count)")
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    // initialize views with core data
    func loadViewWithManagedData() {
        let managedAssignment: ManagedAssignment = fetchedResultsController.fetchedObjects!.first!
        assignmentNameLabel.text = managedAssignment.assignmentName
        assignmentTypeLabel.text = managedAssignment.assignmentType
        assignmentCourse.text = "Course: " + managedAssignment.assignmentCourseName!
        dueDate = managedAssignment.assignmentDate!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, hh:mm a"
        assignmentDueDateLabel.text = "Due on: " +  dateFormatter.string(from: dueDate)
        if (managedAssignment.assignmentUrgency == "No"){
            urgencyLabel.isHidden = true
        }
        
    }

    // MARK: adding to calendar
    @IBAction func Calendar(_ sender: Any) {
        var eventStore = EKEventStore()
        var calendarID: String = ""
            
        eventStore.requestAccess(to: EKEntityType.event, completion: {
            (granted, error) in
            /*
            if granted {
                print("calendar access granted")
            }
            else{
                    print("calendar access denied")
                }
             */
            })
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            let calendars = eventStore.calendars(for: .event)
            for calendar in calendars {
                if calendar.title == "Calendar" {
                    calendarID = calendar.calendarIdentifier
                }
            }
        
            if let calendarForEvent = eventStore.calendar(withIdentifier: calendarID) {
                let newEvent = EKEvent(eventStore: eventStore)
                newEvent.calendar = calendarForEvent
                newEvent.title = assignmentName + " due"
                newEvent.startDate = dueDate
                newEvent.endDate = dueDate
                do {
                    try eventStore.save(newEvent, span: .thisEvent)
                    //print("Event was saved")
                } catch {
                    //print("Error saving event")
                }
            } else {
                //print("did not open calendar")
            }
    }
}


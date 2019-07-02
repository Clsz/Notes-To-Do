//
//  MainViewController.swift
//  Notes To-Do
//
//  Created by Muhammad Reynaldi on 30/06/19.
//  Copyright © 2019 Cls. All rights reserved.
//

// Global Variables
let appDelegate = UIApplication.shared.delegate as? AppDelegate


import UIKit
import CoreData
class MainViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var notesTableView: UITableView!
    
    // Variables
    var notesArray = [Note]()
    
    // Constants
    let cellId = "notesCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchyData()
        cellDelegate()
    }
    
    func cellDelegate(){
        notesTableView.delegate = self
        notesTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchyData()
        notesTableView.reloadData()
    }
    
    func fetchyData(){
        fetchData { (done) in
            if done {
                if notesArray.count > 0 {
                    notesTableView.isHidden = false
                } else {
                    notesTableView.isHidden = true
                }
            }
        }
    }
    
    func callDelegates(){
        notesTableView.delegate = self
        notesTableView.dataSource = self
        notesTableView.isHidden = true
    }
    
    func fetchData(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            notesArray = try  managedContext.fetch(request) as! [Note]
            print("Data fetched, no issues")
            completion(true)
        } catch {
            print("Unable to fetch data: ", error.localizedDescription)
            completion(false)
        }
    }
    
    func deleteData(indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(notesArray[indexPath.row])
        do {
            try managedContext.save()
            print("Data Deleted")
        } catch {
            print("Failed to delete data: ", error.localizedDescription)
        }
    }
    
    func updateTaskStatus(indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let task = notesArray[indexPath.row]
        if task.noteStatus == true {
            task.noteStatus = false
        } else {
            task.noteStatus = true
        }
        do {
            try managedContext.save()
            print("Data updated")
        } catch {
            print("Failed to update data: ", error.localizedDescription)
        }
    }
    
}

extension MainViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NotesTableViewCell
        let task = notesArray[indexPath.row]
        cell.notesDescription.text = task.noteDescription
        if task.noteStatus == true {
            cell.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            cell.notesDescription.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.deleteData(indexPath: indexPath)
            self.fetchyData()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let taskStatusAction = UITableViewRowAction(style: .normal, title: "Completed") { (action, indexPath) in
            self.updateTaskStatus(indexPath: indexPath)
            self.fetchyData()
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        taskStatusAction.backgroundColor = #colorLiteral(red: 1, green: 0.9982944131, blue: 0, alpha: 1)
        deleteAction.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        
        return [deleteAction, taskStatusAction]
    }
    
    
        
}


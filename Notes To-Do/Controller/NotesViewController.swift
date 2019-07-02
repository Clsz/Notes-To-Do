//
//  NotesViewController.swift
//  Notes To-Do
//
//  Created by Muhammad Reynaldi on 30/06/19.
//  Copyright © 2019 Cls. All rights reserved.
//

import UIKit
import CoreData
class NotesViewController: UIViewController {

    // Outlets
    @IBOutlet weak var notesTextView: UITextView!
    
    
    // Variables
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
        saveNotes { (done) in
            if done{
                print("Return To Home")
                navigationController?.popViewController(animated: true)
            }else{
                print("Try Again")
            }
        }
    }
    
    
}

extension NotesViewController{
    func saveNotes(completion: (_ finished:Bool) -> ()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let note = Note(context: managedContext)
        note.noteDescription = notesTextView.text
        note.noteStatus = false
        
        do{
            try managedContext.save()
            print("Data Saved !")
            completion(true)
        }catch{
            print("Failed To Save Data", error.localizedDescription)
            completion(false)
        }
    }
}

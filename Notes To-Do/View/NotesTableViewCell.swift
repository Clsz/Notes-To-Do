//
//  NotesTableViewCell.swift
//  Notes To-Do
//
//  Created by Muhammad Reynaldi on 30/06/19.
//  Copyright © 2019 Cls. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    // Outlets
    
    @IBOutlet weak var notesDescription: UILabel!
    
    //Variables
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}

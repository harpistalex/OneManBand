//
//  EditNotesCell.swift
//  OneManBand
//
//  Created by Alexandra King on 04/07/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import UIKit

class EditNotesCell: UITableViewCell {
    
    @IBOutlet weak var notesTextView: UITextView!
    
    weak var delegate: UITextViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func getText() -> String {
        if let text = notesTextView.text {
            return text
        } else {
            return ""
        }
        
    }
    
}

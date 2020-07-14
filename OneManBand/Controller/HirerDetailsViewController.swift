//
//  HirerDetailsViewController.swift
//  OneManBand
//
//  Created by Alexandra King on 13/07/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import UIKit
import SwiftyJSON

class HirerDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var telephoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    
    var hirer: Contact?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
    }
    
    func updateUI() {
        
        if hirer != nil {
           
            nameLabel.text = "\(hirer!.firstName) \(hirer!.surname)"
            telephoneLabel.text = hirer!.telephone
            emailLabel.text = hirer!.email
            addressLabel.text = Address.createAddressString(address: hirer!.addresses[0])
            notesTextView.text = hirer?.notes
            notesTextView.textContainer.lineFragmentPadding = .zero
            
        }
           
    }

    
    @IBAction func donePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

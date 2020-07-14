//
//  VenueDetailsViewController.swift
//  OneManBand
//
//  Created by Alexandra King on 13/07/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import UIKit
import SwiftyJSON

class VenueDetailsViewController: UIViewController {

    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    
    var venue: Venue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()

    }
    
    func updateUI() {
        
        if venue != nil {
            
            addressLabel.text = Address.createAddressString(address: venue!.venueAddress)
            venueNameLabel.text = venue!.name
            notesTextView.text = venue!.notes
            notesTextView.textContainer.lineFragmentPadding = .zero
            
        }
        
    }
    
    @IBAction func donePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

//
//  VenueDetailsViewController.swift
//  OneManBand
//
//  Created by Alexandra King on 13/07/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

class VenueDetailsViewController: UIViewController {

    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    
    var venue: Venue?
    var addressString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()

    }
    
    func updateUI() {
        
        if venue != nil {
            
            addressString = Address.createAddressString(address: venue!.venueAddress)
            
            addressLabel.text = addressString
            venueNameLabel.text = venue!.name
            notesTextView.text = venue!.notes
            notesTextView.textContainer.lineFragmentPadding = .zero
            
        }
        
    }
    
    @IBAction func toGoogleMaps(_ sender: Any) {
        
        //Using venue name and address:
        var googleAddressString = String()
        let venueNameFormatted = venue!.name.replacingOccurrences(of: " ", with: "+")
        let venueAddressFormatted = addressString.replacingOccurrences(of: " ", with: "+")

        googleAddressString = "\(venueNameFormatted)%2C\(venueAddressFormatted.replacingOccurrences(of: "\n", with: "%2C"))"
        print(googleAddressString)
        
        if let url = URL(string: "https://www.google.com/maps?q=\(googleAddressString)") {
            UIApplication.shared.open(url)
        }
        
        
    }
    
    
    @IBAction func donePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

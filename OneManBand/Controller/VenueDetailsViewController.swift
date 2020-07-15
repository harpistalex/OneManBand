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
        
        var latitude = String()
        var longitude = String()
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(addressString) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
            else {
                // handle no location found
                print("No location found")
                return
            }

            // Use your location
            print(location)
            latitude = "\(location.coordinate.latitude)"
            longitude = "\(location.coordinate.longitude)"
            
            print("Lat/Long: \(latitude), \(longitude)")
            if let url = URL(string: "https://www.google.com/maps?q=\(latitude),\(longitude)") {
                UIApplication.shared.open(url)
            }
            
        }
        

        
        
    }
    
    
    @IBAction func donePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

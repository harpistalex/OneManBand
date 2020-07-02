//
//  EventDetailsViewController.swift
//  OneManBand
//
//  Created by Alexandra King on 01/07/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import UIKit
import SwiftyJSON

class EventDetailsViewController: UIViewController {

    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var serviceIcon: UILabel!
    @IBOutlet weak var confirmedButton: UIButton!
    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var paidButton: UIButton!
    @IBOutlet weak var venueButton: UIButton!
    @IBOutlet weak var hirerButton: UIButton!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    var bookingID = String()
    var gigID = String()
    var booking: FullBooking?
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getBookingData()

    }
    
    //MARK: - Get data
    
    func getBookingData() {
        
        //TODO: ActivityIndicator
        
        //activityIndicator.startAnimating()
        
        Networking.shared.getBooking(eventID: bookingID) { (ApiResponse) in
            switch ApiResponse.success {
            case true: let result : JSON = ApiResponse.data!
            self.booking = FullBooking.parseJsonFullBooking(json: result["booking"])
            //print("BOOKING: \(self.booking)")
            self.updateUI()
            default: print("Failure")
            }
            //self.activityIndicator.stopAnimating()
        }
        
    }
    
    func updateUI() {
        
        if booking != nil {
            //service
            serviceLabel.text = booking!.service
            
            //bookingType
            if booking!.bookingType == "lesson" {
                serviceIcon.text = "\u{f19d}"
            } else {
                serviceIcon.text = "\u{f005}"
            }
            
            //confirmed
            if booking!.confirmed == true {
                confirmedButton.backgroundColor = .ombGreen
                confirmedButton.setTitleColor(.white, for: .normal)
                confirmedButton.setTitle("CONFIRMED", for: .normal)
            } else {
                confirmedButton.backgroundColor = .ombDarkGrey
                confirmedButton.setTitleColor(.ombLightPurple, for: .normal)
                confirmedButton.setTitle("NOT CONFIRMED", for: .normal)
            }
            
            //price
            let price = booking!.totalPrice
            let currencySymbol = getSymbol(forCurrencyCode: booking!.currency)
            let formatted = String(format: "\(currencySymbol ?? "")%.2f", price)
            
            priceButton.setTitle("\(formatted)", for: .normal)
            
            //paid
            if booking!.totalPricePaid == true {
                paidButton.backgroundColor = .ombGreen
                paidButton.setTitleColor(.white, for: .normal)
                paidButton.setTitle("PAID", for: .normal)
            } else {
                paidButton.backgroundColor = .ombDarkGrey
                paidButton.setTitleColor(.ombLightPurple, for: .normal)
                paidButton.setTitle("NOT PAID", for: .normal)
            }
            
            //Gig stuff
            var gigVenue = JSON()
            var gigStart = Date()
            var gigEnd = Date()
            
            for i in 0..<(booking!.gigs.count) {
                if booking!.gigs[i]._id == gigID {
                    gigVenue = booking!.gigs[i].venue
                    gigStart = booking!.gigs[i].startTime
                    gigEnd = booking!.gigs[i].endTime
                }
            }
            
            //venue
            venueButton.setTitle("\(gigVenue["name"].stringValue)", for: .normal)
            
            //hirer
            let hirerName: String = "\(booking!.hirer["firstName"]) \(booking!.hirer["surname"])"
            hirerButton.setTitle("\(hirerName)", for: .normal)
            
            dateFormatter.dateFormat = "dd-MMM-yyyy  H:mm"
            //start
            startLabel.text = dateFormatter.string(from: gigStart)
            
            //end
            endLabel.text = dateFormatter.string(from: gigEnd)

            //notes
            notesLabel.text = "Notes: \(booking!.notes)"
        }
        
    }
    
    func getSymbol(forCurrencyCode code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        if locale.displayName(forKey: .currencySymbol, value: code) == code {
            let newlocale = NSLocale(localeIdentifier: code.dropLast() + "_en")
            return newlocale.displayName(forKey: .currencySymbol, value: code)
        }
        return locale.displayName(forKey: .currencySymbol, value: code)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

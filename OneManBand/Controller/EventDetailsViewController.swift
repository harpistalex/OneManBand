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
    @IBOutlet weak var notesLabel: UITextView!
    
    var bookingID = String()
    var gigID = String()
    var booking: FullBooking?
    var gig: Gig?
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
//            var gigService = String()
//            var gigVenue = JSON()
//            var gigStart = Date()
//            var gigEnd = Date()
            
            for i in 0..<(booking!.gigs.count) {
                if booking!.gigs[i]._id == gigID {
                    gig = booking!.gigs[i]
//                    gigService = booking!.gigs[i].service
//                    gigVenue = booking!.gigs[i].venue
//                    gigStart = booking!.gigs[i].startTime
//                    gigEnd = booking!.gigs[i].endTime
                }
            }
            
            if gig != nil {
                
                //service
                serviceLabel.text = gig!.service
                //venue
                venueButton.setTitle("\(gig!.venue["name"].stringValue)", for: .normal)
                
                dateFormatter.dateFormat = "dd-MMM-yyyy  H:mm"
                //start
                startLabel.text = "Start: \(dateFormatter.string(from: gig!.startTime))"
                
                //end
                endLabel.text = "End: \(dateFormatter.string(from: gig!.endTime))"
                
                //price
                let price = gig!.price
                let currencySymbol = getSymbol(forCurrencyCode: booking!.currency)
                let formatted = String(format: "\(currencySymbol ?? "")%.2f", price)
                
                priceButton.setTitle("\(formatted)", for: .normal)
                
            }

            //hirer
            let hirerName: String = "\(booking!.hirer["firstName"]) \(booking!.hirer["surname"])"
            hirerButton.setTitle("\(hirerName)", for: .normal)

            //notes
            notesLabel.text = "Notes:\n\(booking!.notes)"
            notesLabel.textContainer.lineFragmentPadding = .zero
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
    


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navVC = segue.destination as! UINavigationController
        let destinationVC = navVC.viewControllers.first as! EditEventTableViewController
        
        var eventDetailsToSend = Array<(String, Any)>()
        
        if gig != nil{
            eventDetailsToSend.append(("Event name", gig!.service))
            eventDetailsToSend.append(("Start", gig!.startTime))
            eventDetailsToSend.append(("End", gig!.endTime))
            eventDetailsToSend.append(("Price", gig!.price))
        }
        
        if booking != nil {
            eventDetailsToSend.append(("Notes", booking!.notes))
        }
        
        destinationVC.eventDetails = eventDetailsToSend
        
    }
    
    @IBAction func editEventPressed() {
        performSegue(withIdentifier: K.editEventSegue, sender: self)
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }


}

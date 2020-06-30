//
//  EventDetailsPresentationn.swift
//  OneManBand
//
//  Created by Alexandra King on 29/06/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import UIKit

class EventDetailsPresentation: UITableViewController {
    
    
    var dateArray = Array<Date>()
    let dateToday = Date()
    var dateShown = Date()
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    let jsonDateFormatter = DateFormatter()
    
    var bookings: Array<Booking> = []
    var bookingBooleans: Array<Bool> = []
    var bookingsInOneDay: Array<Booking> = []
    var bookingPointers: Array<Int> = []
    var selectedBooking: Booking?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingPointers.count
    }
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: K.eventDetailsPresentationCellID, for: indexPath)
            
        if bookings.count != 0 {
            print("Label: \(bookings[bookingPointers[indexPath.row]].gig.service)")
            cell.textLabel?.text = "Label: \(bookings[bookingPointers[indexPath.row]].gig.service)"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pointer = bookingPointers[indexPath.row]
        selectedBooking = bookings[pointer]
        //performSegue(withIdentifier: "goToEventDetails", sender: self)
        tableView.deselectRow(at: indexPath, animated: true) //TODO: Is this the correct place for this or should it be above segue?
        
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

// MARK: - Private
private extension EventDetailsPresentation {
  func setupGestureRecognizers() {
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:)))
    view.addGestureRecognizer(tapRecognizer)
  }
}

// MARK: - GestureRecognizerSelectors
private extension EventDetailsPresentation {
  @objc func handleTap(gestureRecognizer: UITapGestureRecognizer) {
    dismiss(animated: true)
  }
}

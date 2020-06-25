//
//  Booking.swift
//  OneManBand
//
//  Created by Alexandra King on 23/06/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Booking: Encodable {
    var id: String
    var invoiced: Bool
    var bookingType: String
    var confirmed: Bool
    var gig: Gig
    var contact: JSON
    
    static func parseJsonBooking(json: JSON) -> Array<Booking> {
        
        let jsonArray = json.arrayValue
        var bookingsArray: Array<Booking> = []
        
        for i in 0..<(jsonArray.count) {
            
            let id: String = json[i]["id"].stringValue
            let invoiced: Bool = json[i]["invoiced"].boolValue
            let bookingType: String = json[i]["bookingType"].stringValue
            let confirmed: Bool = json[i]["confirmed"].boolValue
            let contact: JSON = json[i]["contact"]
            let gig: Gig = Gig.parseJsonGig(json: json[i]["gig"])
            
            bookingsArray.append(Booking(id: id, invoiced: invoiced, bookingType: bookingType, confirmed: confirmed, gig: gig, contact: contact))
            
        }
        
        return bookingsArray
        
    }
    
}

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
    var gig: [Gig]
    var contact: Contact
    
//    func parseJson(json: JSON) -> Booking {
//        
//    }
    
}

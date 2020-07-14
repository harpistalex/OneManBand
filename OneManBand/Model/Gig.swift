//
//  Event.swift
//  OneManBand
//
//  Created by Alexandra King on 23/06/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Gig: Encodable {
    
    var venue: Venue
    var service: String
    var arrivalTime: Date
    var startTime: Date
    var endTime: Date
    var paid: Bool
    var _id: String
    var price: Float
    
    
    static func parseJsonGig(json: JSON) -> Gig {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"


        let venue: Venue = Venue.parseJsonAddress(json: json["venue"])
        let service: String = json["service"].stringValue
        let arrivalTime: Date = dateFormatter.date(from: json["arrivalTime"].stringValue)!
        let startTime: Date = dateFormatter.date(from: json["startTime"].stringValue)!
        let endTime: Date = dateFormatter.date(from: json["endTime"].stringValue)!
        let paid: Bool = json["paid"].boolValue
        print("parseJsonGig paid: \(paid)")
        let _id: String = json["_id"].stringValue
        let price: Float = json["price"].floatValue

        return Gig(venue: venue, service: service, arrivalTime: arrivalTime, startTime: startTime, endTime: endTime, paid: paid, _id: _id, price: price)


    }
    
}

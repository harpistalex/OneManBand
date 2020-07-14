//
//  Venue.swift
//  OneManBand
//
//  Created by Alexandra King on 23/06/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Venue: Encodable {
    
    var _id: String
    var venueAddress: Address
    var venueContact: JSON
    var notes: String
    var name: String
    
    
    static func parseJsonAddress(json: JSON) -> Venue {
        
        let _id: String = json["_id"].stringValue
        let venueAddress: Address = Address.parseJsonAddress(json: json["venueAddress"])
        let venueContact: JSON = json["venueContact"]
        let notes: String = json["notes"].stringValue
        let name: String = json["name"].stringValue
        
        return Venue(_id: _id, venueAddress: venueAddress, venueContact: venueContact, notes: notes, name: name)
        
    }
    
}

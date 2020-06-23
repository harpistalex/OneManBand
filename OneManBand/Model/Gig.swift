//
//  Event.swift
//  OneManBand
//
//  Created by Alexandra King on 23/06/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import Foundation

struct Gig: Encodable {
    
    var venue: Venue
    var service: String
    var arrivalTime: Date
    var startTime: Date
    var endTime: Date
    var paid: Bool
    var _id: String
    var price: Int

}

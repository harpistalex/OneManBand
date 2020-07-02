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
    
    var venue: JSON
    var service: String
    var arrivalTime: Date
    var startTime: Date
    var endTime: Date
    var paid: Bool
    var _id: String
    var price: Float
    
    //TODO: Check with Simon why gigs in booking is not array.
        
//    static func parseJsonGig(json: JSON) -> Array<Gig> {
//
//        print("GIG AGAIN: \(json)")
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//
//        let jsonArray = json.arrayValue
//        var gigsArray: Array<Gig> = []
//
//        for i in 0..<(jsonArray.count) {
//
//            let venue: JSON = json[i]["venue"]
//            let service: String = json[i]["service"].stringValue
//            let arrivalTime: Date = dateFormatter.date(from: json[i]["arrivalTime"].stringValue)!
//            let startTime: Date = dateFormatter.date(from: json[i]["startTime"].stringValue)!
//            let endTime: Date = dateFormatter.date(from: json[i]["endTime"].stringValue)!
//            let paid: Bool = json[i]["paid"].boolValue
//            let _id: String = json[i]["_id"].stringValue
//            let price: Int = json[i]["price"].intValue
//
//            gigsArray.append(Gig(venue: venue, service: service, arrivalTime: arrivalTime, startTime: startTime, endTime: endTime, paid: paid, _id: _id, price: price))
//
//        }
//
//        return gigsArray
//
//    }
    
        static func parseJsonGig(json: JSON) -> Gig {
    
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

    
                let venue: JSON = json["venue"]
                let service: String = json["service"].stringValue
                let arrivalTime: Date = dateFormatter.date(from: json["arrivalTime"].stringValue)!
                let startTime: Date = dateFormatter.date(from: json["startTime"].stringValue)!
                let endTime: Date = dateFormatter.date(from: json["endTime"].stringValue)!
                let paid: Bool = json["paid"].boolValue
                let _id: String = json["_id"].stringValue
                let price: Float = json["price"].floatValue
    
                return Gig(venue: venue, service: service, arrivalTime: arrivalTime, startTime: startTime, endTime: endTime, paid: paid, _id: _id, price: price)

    
        }
    
}

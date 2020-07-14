//
//  FullBooking.swift
//  OneManBand
//
//  Created by Alexandra King on 02/07/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import Foundation
import SwiftyJSON

struct FullBooking: Encodable {
    
    var hirer: Contact
    var clients: Array<JSON>
    var bookingType: String
    var confirmed: Bool
    var service: String
    var notes: String
    var invoice: JSON
    var invoiced: Bool
    var totalPricePaid: Bool
    var adjustment: Float
    var currency: String
    var _id: String
    var gigs: Array<Gig>
    var userId: String
    var tasks: Array<JSON>
    var quotationDate: Date
    var totalPrice: Float
    
        
    static func parseJsonFullBooking(json: JSON) -> FullBooking {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            
        let hirer = Contact.parseJsonContact(json: json["hirer"]) 
        let clients = json["hirer"].arrayValue
        let bookingType = json["bookingType"].stringValue
        let confirmed = json["confirmed"].boolValue
        let service = json["service"].stringValue
        let notes = json["notes"].stringValue
        let invoice = json["invoice"]
        let invoiced = json["invoiced"].boolValue
        let totalPricePaid = json["totalPricePaid"].boolValue
        let adjustment = json["adjustment"].floatValue
        let currency = json["currency"].stringValue
        let _id = json["_id"].stringValue
        
        var gigs: Array<Gig> = []
        
        for i in 0..<(json["gigs"].arrayValue.count) {
            let gig: Gig = Gig.parseJsonGig(json: json["gigs"][i])
            gigs.append(gig)
        }
        
        let userId = json["userId"].stringValue
        let tasks = json["userId"].arrayValue
        let quotationDate: Date = dateFormatter.date(from: json["quotationDate"].stringValue)!
        let totalPrice = json["userId"].floatValue
        
        let booking = FullBooking(hirer: hirer, clients: clients, bookingType: bookingType, confirmed: confirmed, service: service, notes: notes, invoice: invoice, invoiced: invoiced, totalPricePaid: totalPricePaid, adjustment: adjustment, currency: currency, _id: _id, gigs: gigs, userId: userId, tasks: tasks, quotationDate: quotationDate, totalPrice: totalPrice)
            
        return booking
        
    }
    
}

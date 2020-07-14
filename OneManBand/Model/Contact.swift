//
//  Contact.swift
//  OneManBand
//
//  Created by Alexandra King on 23/06/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Contact: Encodable {
    
    
    var notes: String
    var totalInvoiced: Float
    var totalReceived: Float
    var balance: Float
    var _id: String
    var balanced: Bool
    var addresses: [Address]
    var title: String
    var firstName: String
    var surname: String
    var companyName: String
    var email: String
    var website: String
    var telephone: String
    var discovered: String
    var fullName: String
    
    static func parseJsonContact(json: JSON) -> Contact {
        
        var addresses = [Address]()
        
        for i in 0..<(json["addresses"].arrayValue.count) {
            addresses.append(Address.parseJsonAddress(json: json["addresses"][i]))
        }
        
        let notes: String = json["notes"].stringValue
        let totalInvoiced: Float = json["totalInvoiced"].floatValue
        let totalReceived: Float = json["totalReceived"].floatValue
        let balance: Float = json["balance"].floatValue
        let _id: String = json["_id"].stringValue
        let balanced: Bool = json["balanced"].boolValue
        let title: String = json["title"].stringValue
        let firstName: String = json["firstName"].stringValue
        let surname: String = json["surname"].stringValue
        let companyName: String = json["companyName"].stringValue
        let email: String = json["email"].stringValue
        let website: String = json["website"].stringValue
        let telephone: String = json["telephone"].stringValue
        let discovered: String = json["discovered"].stringValue
        let fullName: String = json["fullName"].stringValue
        
        return Contact(notes: notes, totalInvoiced: totalInvoiced, totalReceived: totalReceived, balance: balance, _id: _id, balanced: balanced, addresses: addresses, title: title, firstName: firstName, surname: surname, companyName: companyName, email: email, website: website, telephone: telephone, discovered: discovered, fullName: fullName)
        
        
    }
    
}

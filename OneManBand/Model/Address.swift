//
//  Address.swift
//  OneManBand
//
//  Created by Alexandra King on 23/06/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Address: Encodable {
    
    var coordinates: [JSON]
    var _id: String
    var country: String
    var line1: String
    var line2: String
    var line3: String
    var line4: String
    var city: String
    var state: String
    var postcode: String
    
    static func parseJsonAddress(json: JSON) -> Address {
    
        let coordinates: [JSON] = json["coordinates"].arrayValue
        let _id: String = json["_id"].stringValue
        let country: String = json["country"].stringValue
        let line1: String = json["line1"].stringValue
        let line2: String = json["line2"].stringValue
        let line3: String = json["line3"].stringValue
        let line4: String = json["line4"].stringValue
        let city: String = json["city"].stringValue
        let state: String = json["state"].stringValue
        let postcode: String = json["postcode"].stringValue
        
        return Address(coordinates: coordinates, _id: _id, country: country, line1: line1, line2: line2, line3: line3, line4: line4, city: city, state: state, postcode: postcode)
        
    }
    
    static func createAddressString(address: Address) -> String {
        
        var addressArray = [String]()
        var addressString = String()
        
        if address.line1 != "" {
            addressArray.append(address.line1)
        }
        if address.line2 != "" {
            addressArray.append(address.line2)
        }
        if address.line3 != "" {
            addressArray.append(address.line3)
        }
        if address.line4 != "" {
            addressArray.append(address.line4)
        }
        if address.city != "" {
            addressArray.append(address.city)
        }
        if address.state != "" {
            addressArray.append(address.state)
        }
        if address.postcode != "" {
            addressArray.append(address.postcode)
        }
        if address.country != "" {
            addressArray.append(address.country)
        }
        
        //check to see if there is an address at all:
        if addressArray.count > 0 {
            for i in 0..<(addressArray.count - 1) {
                addressString.append("\(addressArray[i])\n")
            }
        }

        //will return empty string if no values are available.
        addressString.append("\(addressArray.last ?? "")")
        
        return addressString
        
    }
    
}

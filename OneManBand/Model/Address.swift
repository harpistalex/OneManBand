//
//  Address.swift
//  OneManBand
//
//  Created by Alexandra King on 23/06/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import Foundation

struct Address: Encodable {
    
    var coordinates: [Int]
    var _id: String
    var line1: String
    var line2: String
    var line3: String
    var postcode: String
    var line4: String
    
}

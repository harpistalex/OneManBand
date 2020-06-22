//
//  DateExtensions.swift
//  OneManBand
//
//  Created by Alexandra King on 22/06/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import Foundation

extension Date {
    
    func getDay() -> Int {
        return Calendar.current.component(.day, from: self)
    }
    
    func getMonth() -> String {
        let month = Calendar.current.component(.month, from: self)
        return Calendar.current.monthSymbols[month - 1]
    }
    
    func getMonthNum() -> Int {
        return Calendar.current.component(.month, from: self)
    }
    
    func getYear() -> Int {
        return Calendar.current.component(.year, from: self)
    }
    
    func getWeekDayNum() -> Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    func getHour() -> Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    func getMinute() -> Int {
        return Calendar.current.component(.minute, from: self)
    }
    
}

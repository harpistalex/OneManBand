//
//  CustomCalendar.swift
//  OneManBand
//
//  Created by Alexandra King on 22/06/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import UIKit

class CustomCalendar {
    
    var dateCustomCalendar = Date()
    private let calendar = Calendar.current

    func currentMonthStart() -> Date {
        
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month, .hour], from: dateCustomCalendar)
        let startOfMonth = Calendar.current.date(from: comp)!

        return startOfMonth
        
    }
    
    func findFirstMonday(startDay: Date) -> Date {
        
        var weekdayNum = calendar.component(.weekday, from: startDay)

        //Make Sunday last day in the week:
        if weekdayNum == 1 {
            weekdayNum = 8
        }
        
        let modifiedWeekdayNum = weekdayNum - 2

        let daysBeforeFirst = ((modifiedWeekdayNum) % 7)

        var comp1 = DateComponents()

        comp1.day = -(daysBeforeFirst)
        comp1.hour = 1
        
        let firstMonday = Calendar.current.date(byAdding: comp1, to: startDay)
        
        return firstMonday!
        
    }

    func createDateArray(firstMonday: Date) -> Array<Date>{
        
    
        var date = firstMonday
        var listOfDatesToShow = Array<Date>()
        
        for _ in 0...41 {
            
            listOfDatesToShow.append(date)
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            
        }
        
        return listOfDatesToShow
        
    }

}

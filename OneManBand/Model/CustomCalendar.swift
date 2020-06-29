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
        comp1.hour = 1 //TODO: Daylight savings?!
        
        let firstMonday = Calendar.current.date(byAdding: comp1, to: startDay)
        
        return firstMonday! //UNWRAP
        
    }
    
    func findLastSunday(currentMonth: Date) -> Date {
        
        //When using this, input startOfMonth as current month.

        var lastSunday = Date()
        
        var comps = DateComponents()
        comps.month = 1 //Goes to the first day of the next month.
        comps.day = -1 //Goes to the day before (ie the final day of the previous month).
        let endOfMonth = Calendar.current.date(byAdding: comps, to: currentMonth)! //Unwrap...
        
        switch endOfMonth.getWeekDayNum(){
        case 1: lastSunday = endOfMonth
        case 2: lastSunday = Calendar.current.date(byAdding: .day, value: 6, to: endOfMonth)!
        case 3: lastSunday = Calendar.current.date(byAdding: .day, value: 5, to: endOfMonth)!
        case 4: lastSunday = Calendar.current.date(byAdding: .day, value: 4, to: endOfMonth)!
        case 5: lastSunday = Calendar.current.date(byAdding: .day, value: 3, to: endOfMonth)!
        case 6: lastSunday = Calendar.current.date(byAdding: .day, value: 2, to: endOfMonth)!
        default: lastSunday = Calendar.current.date(byAdding: .day, value: 1, to: endOfMonth)!
        }
        
        return lastSunday
        
    }

    func createDateArray(firstMonday: Date, lastSunday: Date) -> Array<Date>{
        
        var date = firstMonday
        var listOfDatesToShow = Array<Date>()
        
        while date <= lastSunday {
            listOfDatesToShow.append(date)
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)! //Unwrap...
        }
        
        listOfDatesToShow.append(lastSunday)
        
        //Make sure there are always 6 columns in the calendarCollectionView:
        if listOfDatesToShow.count < 42 {
            
            var date2 = Calendar.current.date(byAdding: .day, value: 1, to: lastSunday)!
            
            for _ in 0...6 {
                listOfDatesToShow.append(date2)
                date2 = Calendar.current.date(byAdding: .day, value: 1, to: date2)! //Unwrap...
            }
            
        }
        
        return listOfDatesToShow
        
    }

}

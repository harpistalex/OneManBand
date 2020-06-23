//
//  CalendarViewController.swift
//  OneManBand
//
//  Created by Alexandra King on 22/06/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import UIKit
import SwiftyJSON

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var calendarView: UICollectionView!
    @IBOutlet weak var monthYearLabel: UILabel!
    
    let customCalendar = CustomCalendar()
    var dateArray = Array<Date>()
    let dateToday = Date()
    var dateShown = Date()
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    let jsonDateFormatter = DateFormatter()
    
    var bookings: Array<JSON> = []
    var bookingBooleans: Array<Bool> = []
    var bookingsInOneDay: Array<Booking> = []
    var bookingPointers: Array<Int> = []
    var selectedBooking: Booking?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.register(UINib(nibName: "DateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "dateCell")

        jsonDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        customCalendar.dateCustomCalendar = dateToday
        monthYearLabel.text = "\(dateShown.getMonth()) \(dateShown.getYear())"
        
        populateDateArray()
        getBookingDates()
        
    }
    
    
        //MARK: - Custom Calendar functions:
        
        @IBAction func previousMonthPressed(_ sender: Any) {
            
            bookingPointers = []
            //eventDetailsTableView.reloadData()
            
            var comps = DateComponents()
            comps.month = -1
            
            let nextMonth = calendar.date(byAdding: comps, to: dateShown)
            dateShown = nextMonth!
            
            monthYearLabel.text = "\(dateShown.getMonth()) \(dateShown.getYear())"
            
            customCalendar.dateCustomCalendar = dateShown
            
            populateDateArray()
            getBookingDates()
            
            calendarView.reloadData()
            
        }
        
        @IBAction func nextMonthPressed(_ sender: Any) {
            
            bookingPointers = []
            //eventDetailsTableView.reloadData()
            
            var comps = DateComponents()
            comps.month = 1
            
            let nextMonth = calendar.date(byAdding: comps, to: dateShown)
            dateShown = nextMonth!
            
            monthYearLabel.text = "\(dateShown.getMonth()) \(dateShown.getYear())"
            
            customCalendar.dateCustomCalendar = dateShown
            
            populateDateArray()
            getBookingDates()
            
            calendarView.reloadData()
            
        }
        
        
        func populateDateArray() {
            
            let currentMonth = customCalendar.currentMonthStart()
            let firstMonday = customCalendar.findFirstMonday(startDay: currentMonth)
            let lastSunday = customCalendar.findLastSunday(currentMonth: currentMonth)
            print(lastSunday)

            dateArray = customCalendar.createDateArray(firstMonday: firstMonday, lastSunday: lastSunday)
            bookingBooleans = Array<Bool>(repeating: false, count: dateArray.count)
            
            print("dateArray count and bookingsBooleans count: \(dateArray.count) \(bookingBooleans.count)")
            
        }
        
        func getBookingDates() {
            
            let currentMonth = customCalendar.currentMonthStart()
            let firstMonday = customCalendar.findFirstMonday(startDay: currentMonth)
            let lastSunday = customCalendar.findLastSunday(currentMonth: currentMonth)
            
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let startDate = dateFormatter.string(from: firstMonday)
            let endDate = dateFormatter.string(from: lastSunday)
            
            //activityIndicator.startAnimating()
            
            Networking.shared.getBookingDates(currentMonth: currentMonth, firstMonday: firstMonday, lastSunday: lastSunday, startDate: startDate, endDate: endDate) { (ApiResponse) in
                    switch ApiResponse.success {
                    case true: let result : JSON = ApiResponse.data!
                    print(result.arrayValue)
                        self.bookings = result["bookings"].arrayValue
                        self.addBookingsToCalendar(bookings: self.bookings)
                        self.calendarView.reloadData()
                        
                    default: print("Failed to log in")
                    }
                    //self.activityIndicator.stopAnimating()
                }
                  
        }
        
        func addBookingsToCalendar(bookings: Array<JSON>) {
            
            if bookings.isEmpty {
                print("No bookings this month")
            } else {

                for x in 0..<bookings.count  {
                    
                    let bookingDateString = "\(bookings[x]["gig"]["startTime"])"
                    print(bookingDateString)
                    
                    if let dateOfBooking = jsonDateFormatter.date(from: bookingDateString) {
                        print("dateOfBooking: \(String(describing: dateOfBooking))")
                        
                        for i in 0..<dateArray.count {
                            if compareDates(dateOfBooking: dateOfBooking, dateInCalendar: dateArray[i]) {
                                print("Date in calendar: \(dateArray[i])")
                                bookingBooleans[i] = true
                            }
                        }
                    
                    }
                    
                }
                
            }
            
        }
        
        func compareDates(dateOfBooking: Date, dateInCalendar: Date) -> Bool {
            
            if dateOfBooking.getYear() != dateInCalendar.getYear() {
                return false
            } else if dateOfBooking.getMonth() != dateInCalendar.getMonth() {
                return false
            } else if dateOfBooking.getDay() != dateInCalendar.getDay() {
                return false
            } else {
                return true
            }
            
        }
        
        // MARK: - Navigation

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            //let destinationVC = segue.destination as! EventDetailsViewController
            //destinationVC.event = selectedBooking
        }

}

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCollectionViewCell
        
        
        print("Frame: \(cell.bounds)")
        print("Frame 2: \(cell.contentView.bounds)")
        
        //cell.contentView.frame.width = cell.frame.width
        //cell.contentView.frame.height = cell.frame.height
   
        cell.bookingIcon.isHidden = true
        
        let dayNumber = dateArray[indexPath.item].getDay()
        cell.dateLabel.text = "\(dayNumber)"
        
        //Set weekends to grey:
//        switch dateArray[indexPath.item].getWeekDayNum() {
//        case 7: cell.backgroundColor = UIColor.lightGray
//        case 1: cell.backgroundColor = UIColor.lightGray
//        default: cell.backgroundColor = UIColor.clear
//        }
        
        //Set current day to magenta:
        if cell.dateLabel.text == "\(dateToday.getDay())" && dateShown.getMonth() == dateToday.getMonth() && dateShown.getYear() == dateToday.getYear() {
            cell.dateLabel.textColor = UIColor.magenta
        }
        
        //Colour previous and next month's dates:
        if dateArray[indexPath.item].getMonthNum() != dateShown.getMonthNum() {
            cell.dateLabel.textColor = UIColor.gray
        }
        
        if bookingBooleans[indexPath.item] {
            cell.bookingIcon.isHidden = false
        }
        
        return cell
        
    }

    //Set the size for the cells:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionWidth = collectionView.bounds.width - 2
        let collectionHeight = collectionView.bounds.height - 2

        return CGSize(width: collectionWidth / 7, height: collectionHeight / 6)
    
    }
    
}

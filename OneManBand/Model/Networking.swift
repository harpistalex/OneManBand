//
//  Networking.swift
//  OneManBand
//
//  Created by Alexandra King on 22/06/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class Networking {
    
    //SINGLETON. The object creates itself and can't be initialised outside of here because the init is private. To access, call Networking.shared.
    static var shared = Networking()
    
    private var ombURL: String = "https://omb-backend-cloudrun-txzqmjv3mq-ew.a.run.app"
    private var headers: HTTPHeaders = [
        "Authorization": ""
    ]
    
    private init() { }
    
    //MARK: - Networking functions
    
    func login(email: String, password: String, completionHandler: @escaping (ApiResponse) -> ()) {

        let loginURL: String = "\(ombURL)/auth/local/login"
        let login = LoginData(email: email, password: password)

        //TODO: Request is still success even if email and pw are empty strings... BECAUSE LOG IN IS USING HARD CODED LOGIN DETAILS?? Or maybe because you're already logged in?

        AF.request(loginURL, method: .post, parameters: login, encoder: JSONParameterEncoder.default).responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("Success! Got the user data.")

                    let json = JSON(value)

                    let ombKey = "Bearer \(json["token"].stringValue)"

                    self.headers["Authorization"] = ombKey

                    print("Your auth token is: \(self.headers["Authorization"] ?? "Key not found")")
                    
                    completionHandler(ApiResponse(success: true, data: json as JSON))

                case .failure(_):

                print("Error \(String(describing: response))")
                completionHandler(ApiResponse(success: false))
            }
        }
    }
    
    func logout() -> Bool {
        
       headers = [
               "Authorization": ""
           ]
        return true
    }
    
    func getAllContacts(completionHandler: @escaping (ApiResponse) -> ()) {
        
        let allContactsURL: String = "\(ombURL)/api/allcontacts?offset=0"
        
        AF.request(allContactsURL, method: .get, headers: headers).response {
            response in
        
            switch response.result {
            case .success(let value):
                print("Success! Got the contacts data.")
                
                if let result = value {
                    let json = JSON(result)
                    completionHandler(ApiResponse(success: true, data: json as JSON))

                    
                    //self.tableView.reloadData()

                } else {
                    print("no contacts found")
                }

            case .failure(_):
        
                print("Error \(String(describing: response))")
                completionHandler(ApiResponse(success: false))

            }
        }
    }
    
    func getBookingDates(currentMonth: Date, firstMonday: Date, lastSunday: Date, startDate: String, endDate: String, completionHandler: @escaping (ApiResponse) -> ()) {
        
        let allBookingsURL: String = "\(ombURL)/api/gigByDate?startDate=\(startDate)&endDate=\(endDate)"
               
               AF.request(allBookingsURL, method: .get, headers: headers).response {
                   response in
               
                   switch response.result {
                   case .success(let value):
                       print("Success! Got the booking data.")
                       
                       if let result = value {
                            let json = JSON(result)
                            completionHandler(ApiResponse(success: true, data: json as JSON))

                       } else {
                           print("no contacts found")
                       }

                   case .failure(_):
               
                       print("Error \(String(describing: response))")

                   }
               }
        
        
    }
    
    func getBooking(eventID: String, completionHandler: @escaping (ApiResponse) -> ()) {
        
        let bookingURL: String = "\(ombURL)/api/bookings/\(eventID)"
        
        AF.request(bookingURL, method: .get, headers: headers).response {
            response in
        
            switch response.result {
            case .success(let value):
                print("Success! Got the booking data.")
                
                if let result = value {
                    let json = JSON(result)
                    completionHandler(ApiResponse(success: true, data: json as JSON))

                } else {
                    print("no contacts found")
                }

            case .failure(_):
        
                print("Error \(String(describing: response))")
                completionHandler(ApiResponse(success: false))

            }
        }
        
    }
    

    func editGig(bookingID: String, gigID: String, parameters: EditGigData, completionHandler: @escaping (ApiResponse) -> ()) {
        
        let bookingURL: String = "\(ombURL)/api/bookings/\(bookingID)/gigs/\(gigID)"
        
        AF.request(bookingURL, method: .put, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).validate().response {

            response in
            switch response.result {
            case .success(let value):
                print("viewDidLoad: Success! Saved the data.")
                
                if let result = value {
                    let json = JSON(result)
                    print("json result: \(json)")
                    completionHandler(ApiResponse(success: true, data: json as JSON))

                } else {
                    print("viewDidLoad: Could not save data")
                }

            case .failure(_):
        
                print("Error \(String(describing: response))")
                completionHandler(ApiResponse(success: false))

            }
        }
        

    }
    
    func editBooking(bookingID: String, parameters: EditBookingData, completionHandler: @escaping (ApiResponse) -> ()) {
        
        let bookingURL: String = "\(ombURL)/api/bookings/\(bookingID)"
        
        AF.request(bookingURL, method: .put, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).validate().response {

            response in
            switch response.result {
            case .success(let value):
                print("viewDidLoad: Success! Saved the data.")
                
                if let result = value {
                    let json = JSON(result)
                    print("json result: \(json)")
                    completionHandler(ApiResponse(success: true, data: json as JSON))

                } else {
                    print("viewDidLoad: Could not save data")
                }

            case .failure(_):
        
                print("Error \(String(describing: response))")
                completionHandler(ApiResponse(success: false))

            }
        }
        
    }

}

//MARK: - Response

class ApiResponse {
    var success: Bool!   // whether the API call passed or failed
    var message: String? // message returned from the API
    var data: JSON? // actual data returned from the API
    init(success: Bool, message: String? = nil, data: JSON? = nil) {
        self.success = success
        self.message = message
        self.data = data
    }
}

//MARK: - Parameter structs
 
 struct LoginData: Encodable {
     let email: String
     let password: String
 }

 struct EditGigData: Encodable {
     let service: String?
     let startTime: String?
     let endTime: String?
     let price: Float?
     let paid: Bool?
     
 }
 
 struct EditBookingData: Encodable {
     let bookingType: String?
     let confirmed: Bool?
     let service: String?
     let notes: String?
     let invoiced: Bool?
     let totalPricePaid: Bool?
     let totalPrice: String?
     
 }

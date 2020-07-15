//
//  EditEventTableViewController.swift
//  OneManBand
//
//  Created by Alexandra King on 04/07/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import UIKit

class EditEventTableViewController: UITableViewController {
    
    var bookingID = String()
    var gigID = String()
    var eventDetails = Array<(String, Any)>()

    var datePickerIndexPath : IndexPath?
    var eventDetailsReference : IndexPath?
    var notesIndexPath : IndexPath?
    
    let jsonDateFormatter = DateFormatter()
    let dateFormatter = DateFormatter()
    
    var remainingSpace = CGFloat()
    var notesCellHeight = CGFloat()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "dd-MMM-yyyy  H:mm"
        jsonDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        tableView.register(UINib(nibName: K.editEventEditEventCellName, bundle: nil), forCellReuseIdentifier: K.editEventEditEventCellID)
        tableView.register(UINib(nibName: K.editEventDatePickerCellName, bundle: nil), forCellReuseIdentifier: K.editEventDatePickerCellID)
        tableView.register(UINib(nibName: K.editEventEditNotesCellName, bundle: nil), forCellReuseIdentifier: K.editEventEditNotesCellID)
        
        print(bookingID)
        
        self.setupResignFirstResponderOnTap()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // If datePicker is already present, we add one extra cell for that
         if datePickerIndexPath != nil {
            return eventDetails.count + 1
         } else {
            return eventDetails.count
         }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         if datePickerIndexPath == indexPath {
            let datePickerCell = tableView.dequeueReusableCell(withIdentifier: "datePickerCell") as! DatePickerCell
            datePickerCell.updateCell(date: eventDetails[indexPath.row - 1].1 as! Date, indexPath: indexPath)
            datePickerCell.delegate = self
            return datePickerCell

         } else if eventDetails[indexPath.row].0 == "Start" || eventDetails[indexPath.row].0 == "End" {
            let dateCell = tableView.dequeueReusableCell(withIdentifier: K.editEventEditEventCellID, for: indexPath) as! EditEventCell
            dateCell.valueTextView.isUserInteractionEnabled = false
             
            dateCell.keyLabel.text = eventDetails[indexPath.row].0
            dateCell.valueTextView.text = dateFormatter.string(from: eventDetails[indexPath.row].1 as! Date)
            return dateCell

         } else if eventDetails[indexPath.row].0 == "Event name" {
            let textViewCell = tableView.dequeueReusableCell(withIdentifier: K.editEventEditEventCellID, for: indexPath) as! EditEventCell
            textViewCell.valueTextView.isUserInteractionEnabled = false
            
            textViewCell.valueTextView.delegate = self
             
            textViewCell.keyLabel.text = eventDetails[indexPath.row].0
            textViewCell.valueTextView.text = "\(eventDetails[indexPath.row].1)"
             
            textViewCell.valueTextView.addDoneButtonOnKeyboard()
             
            return textViewCell
             
         } else if eventDetails[indexPath.row].0 == "Price" {
            let textViewCell = tableView.dequeueReusableCell(withIdentifier: K.editEventEditEventCellID, for: indexPath) as! EditEventCell
            textViewCell.valueTextView.isUserInteractionEnabled = false
            
            textViewCell.valueTextView.delegate = self
            
            textViewCell.valueTextView.keyboardType = .numberPad
            textViewCell.valueTextView.addDoneButtonOnKeyboard()
            textViewCell.tag = 1
        
            
            textViewCell.keyLabel.text = eventDetails[indexPath.row].0
            textViewCell.valueTextView.text = "\(eventDetails[indexPath.row].1)"
            
            return textViewCell
        
        } else if eventDetails[indexPath.row].0 == "Notes" {
            let textViewCell = tableView.dequeueReusableCell(withIdentifier: K.editEventEditNotesCellID, for: indexPath) as! EditNotesCell
            textViewCell.notesTextView.isUserInteractionEnabled = false
            
            textViewCell.notesTextView.delegate = self
            textViewCell.notesTextView.addDoneButtonOnKeyboard()
            textViewCell.tag = 2
        
            textViewCell.notesTextView.text = "\(eventDetails[indexPath.row].1)"
            notesIndexPath = indexPath
            
            //To calculate cell size
            remainingSpace = view.frame.maxY - textViewCell.frame.minY
            notesCellHeight = remainingSpace
            return textViewCell

        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.editEventEditEventCellID, for: indexPath) as! EditEventCell
            cell.valueTextView.isEditable = false
            cell.keyLabel.text = eventDetails[indexPath.row].0
            cell.valueTextView.text = "\(eventDetails[indexPath.row].1)"
            return cell
        }
         
     }

    //MARK: - TableView user interaction:
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        eventDetailsReference = indexPath
        
        if let datePickerIndexPath = datePickerIndexPath {
            
            //If indexPath.row is greater than datePickerindexPath.row, indexPath.row (or eventDetailsReference) needs to be -1 smaller to access the correct info in the eventDetails array.
            if eventDetailsReference!.row > datePickerIndexPath.row {
                eventDetailsReference!.row -= 1

            }
        }

        tableView.beginUpdates()
           
        // 1: Date picker is showing, and row above is selected. Date picker needs to be removed.
           if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row - 1 == indexPath.row {
            tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
            self.datePickerIndexPath = nil
            notesIndexPath!.row -= 1
           } else {
           
            // 2: A date row is selected where the date picker isn't showing, or is showing somewhere else:
            //2a: First delete any date picker already showing somewhere else.
            if let datePickerIndexPath = datePickerIndexPath {
                tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
                notesIndexPath!.row -= 1
                
            }
            
            //2b: Now insert the date picker below the selected row, and deselect the selected row.
            
            if eventDetails[eventDetailsReference!.row].0 == "Start" || eventDetails[eventDetailsReference!.row].0 == "End" {
                
                //Details contain date:
                datePickerIndexPath = indexPathToInsertDatePicker(indexPath: indexPath)
                tableView.insertRows(at: [datePickerIndexPath!], with: .fade)
                tableView.deselectRow(at: indexPath, animated: true)
                notesIndexPath!.row += 1
                
            //Details don't contain date:
            } else {
                self.datePickerIndexPath = nil
                
                if eventDetails[eventDetailsReference!.row].0 == "Notes" {
                    let notesCell = tableView.cellForRow(at: indexPath) as! EditNotesCell
                    notesCell.notesTextView.isUserInteractionEnabled = true
                    notesCell.notesTextView.becomeFirstResponder()
                    print("Notes cell")
                } else {
                    let editCell = tableView.cellForRow(at: indexPath) as! EditEventCell
                    editCell.valueTextView.isUserInteractionEnabled = true
                    editCell.valueTextView.becomeFirstResponder()
                    print("Edit cell")
                }

            }
            
            
        }
        
        tableView.endUpdates()
         
    }
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if datePickerIndexPath != indexPath {
            if eventDetails[eventDetailsReference!.row].0 == "Notes" {
                let notesCell = tableView.cellForRow(at: indexPath) as! EditNotesCell
                notesCell.notesTextView.isUserInteractionEnabled = false
            
            } else {
                let editCell = tableView.cellForRow(at: indexPath) as! EditEventCell
                editCell.valueTextView.isUserInteractionEnabled = false
            }

        }
    }
    
    
    //MARK: - Save/Cancel
    
    @IBAction func savePressed(_ sender: Any) {
        
        //self.activityIndicator.startAnimating()
        
       print("eventDetails: \(eventDetails)")
        let gigParameters = EditGigData(service: (eventDetails[0].1 as! String),
                                        startTime: jsonDateFormatter.string(from: eventDetails[1].1 as! Date),
                                        endTime: jsonDateFormatter.string(from: eventDetails[2].1 as! Date),
                                        price: (eventDetails[3].1 as! Float),
                                        paid: nil)
        
        let bookingParameters = EditBookingData(bookingType: nil, confirmed: nil, service: nil, notes: (eventDetails[4].1 as! String), invoiced: nil, totalPricePaid: nil, totalPrice: nil)
        
        Networking.shared.editBooking(bookingID: bookingID, parameters: bookingParameters) { (ApiResponse) in

            switch ApiResponse.success {
            case true:
                Networking.shared.editGig(bookingID: self.bookingID, gigID: self.gigID, parameters: gigParameters) { (ApiResponse) in
                switch ApiResponse.success {
                case true: self.performSegue(withIdentifier: K.editEventUnwind, sender: self)
                default: print("Failed to save data") //TODO: Toast?
                }

            }
            default: print("Failed to save data") //TODO: Toast?
            }

            //self.activityIndicator.stopAnimating()
                    
                
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        //Show toast?
        self.dismiss(animated: true, completion: nil)
        
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! EventDetailsViewController
        destinationVC.getBookingData()
    }

}

//MARK: - DatePicker delegates

extension EditEventTableViewController: DatePickerDelegate {

    func didChangeDate(date: Date, indexPath: IndexPath) {
        
        //Update eventDetails array:
        eventDetails[indexPath.row].1 = date
        
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    //To find the index path needed to insert the date picker, when the user selects a row.
    func indexPathToInsertDatePicker(indexPath: IndexPath) -> IndexPath {
       if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row < indexPath.row {
        return indexPath
       } else {
        return IndexPath(row: indexPath.row + 1, section: indexPath.section)
       }
    }
    
    //MARK: - Set cell height
    
    //Set the height of the cells according to which cell is showing.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if datePickerIndexPath == indexPath {
            return CGFloat(162.0)
        } else if notesIndexPath == indexPath {
            return remainingSpace / 1.20
        } else {
            return CGFloat(44)
        }
    }

}

//MARK: - TextView delegates

extension EditEventTableViewController: UITextViewDelegate {
    

    func textViewDidBeginEditing(_ textView: UITextView) {
        //textView.backgroundColor = .ombLightGrey
        //textView.scrollRangeToVisible(textView.selectedRange)
        
        //To calculate cell size
        remainingSpace = (view.frame.maxY - textView.frame.minY) / 2
        tableView.beginUpdates()
        tableView.endUpdates()
        
        
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        //textView.backgroundColor = .ombLightGrey
        textView.isUserInteractionEnabled = false
        textView.resignFirstResponder()
        //print("didEndEditing: \(textView.text ?? "")")
        
        //Save string value to eventDetails array.
        if eventDetailsReference?.row == 0 || eventDetailsReference?.row == 4 {
            eventDetails[eventDetailsReference!.row].1 = textView.text ?? ""
            //print("Details to save: \(eventDetails[eventDetailsReference!.row].1)")
        }
        
        //price needs to be float.
        if eventDetailsReference?.row == 3 {
            eventDetails[eventDetailsReference!.row].1 = Float(textView.text) ?? 0
            //print("Details to save: \(eventDetails[eventDetailsReference!.row].1)")
        }
        
        //To calculate cell size
        remainingSpace = notesCellHeight
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    //Dissmisses the keyboard when return is pressed:
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //TODO: Done button instead of pressing return.
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        } else {
            if textView.tag == 1 {
               return textLimit(existingText: textView.text, newText: text, limit: 20)
            } else {
                //notes cell
                return true
            }
            
        }

        
    }
    
    private func textLimit(existingText: String?, newText: String, limit: Int) -> Bool {
        let text = existingText ?? ""
        let isAtLimit = text.count + newText.count <= limit
        return isAtLimit
    }


}


//MARK: - Tap gesture

extension UITableViewController {
    // Call this once to resign first responder by tapping anywhere in the view controller
    func setupResignFirstResponderOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }

    // Resign first responder
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}


//
//  ViewController.swift
//  getirHackathon
//
//  Created by Emre HAVAN on 25.01.2018.
//  Copyright © 2018 Emre HAVAN. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var startingDateTextField: UITextField!
    @IBOutlet weak var endingDateTextField: UITextField!
    @IBOutlet weak var minimumCountTextField: UITextField!
    @IBOutlet weak var maximumCountTextField: UITextField!
    
    let datePicker = UIDatePicker()
    let requiredFieldAlertTitle = NSLocalizedString("requiredFieldsAlert", comment: "")
    let requiredFieldsAlertDetail = NSLocalizedString("requiredFieldsAlertDetail", comment: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        minimumCountTextField.delegate = self
        maximumCountTextField.delegate = self
        createDatePicker()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func startPressed(_ sender: Any) {
        minimumCountTextField.resignFirstResponder()
        maximumCountTextField.resignFirstResponder()
        
        guard (!(startingDateTextField.text?.isEmpty)!), (!(endingDateTextField.text?.isEmpty)!), (!(minimumCountTextField.text?.isEmpty)!), (!(maximumCountTextField.text?.isEmpty)!) else {
            showAlert(title: requiredFieldAlertTitle, message: requiredFieldsAlertDetail)
            return
        }
        
        performSegue(withIdentifier: "showData", sender: [startingDateTextField.text, endingDateTextField.text, minimumCountTextField.text, maximumCountTextField.text])
    }
    
    //MARK: Settings of date pickers.
    func createDatePicker() {
        
        let toolBarOfStarting = UIToolbar()
        toolBarOfStarting.sizeToFit()
        let toolBarOfEnding = UIToolbar()
        toolBarOfEnding.sizeToFit()
        
        let doneForStarting = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedForStarting))
        let doneForEnding = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedForEnding))
        toolBarOfStarting.setItems([doneForStarting], animated: false)
        toolBarOfEnding.setItems([doneForEnding], animated: false)
        
        startingDateTextField.inputAccessoryView = toolBarOfStarting
        startingDateTextField.inputView = datePicker
        endingDateTextField.inputAccessoryView = toolBarOfEnding
        endingDateTextField.inputView = datePicker
        datePicker.datePickerMode = .date
        
    }
    
    @objc func donePressedForStarting() {
        
        donePressedFor(picker: startingDateTextField)
    }
    
    @objc func donePressedForEnding() {
        
        donePressedFor(picker: endingDateTextField)
    }
    
    func donePressedFor(picker textField: UITextField) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: datePicker.date)
        
        textField.text =  "\(dateString)"
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let guest = segue.destination as! LoadDataTableViewController
        guest.incommingParameters.append(contentsOf: sender as! [String])
    }
    
    @objc func dismissKeyboard(tap: UITapGestureRecognizer) {
        minimumCountTextField.resignFirstResponder()
        maximumCountTextField.resignFirstResponder()
    }

}



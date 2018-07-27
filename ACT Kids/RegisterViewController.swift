//
//  RegisterViewController.swift
//  ACT Kids
//
//  Created by Patrick E. McKenna on 3/10/18.
//  Copyright © 2018 Patrick McKenna. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class RegisterViewController: UIViewController
    
{

    
    // MARK: Properties
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet weak var datePickerTF: UITextField!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
    }
    
    func createDatePicker(){
        
        // assign date picker to the textField
        datePickerTF.inputView = datePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        toolbar.setItems([doneButton], animated: true)
        
        datePickerTF.inputAccessoryView = toolbar
        datePicker.datePickerMode = .date
    }
    
    @objc func doneClicked()
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        datePickerTF.text = "\(datePicker.date)"
        self.view.endEditing(true)
    }
    @IBOutlet var emailAddressTextField: UITextField!
    @IBOutlet var parentNameTextField: UITextField!

    
   

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    }
extension RegisterViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameTextField:
            lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            datePickerTF.becomeFirstResponder()
        case datePickerTF:
            emailAddressTextField.becomeFirstResponder()
        case emailAddressTextField:
            parentNameTextField.becomeFirstResponder()
        default:
            parentNameTextField.resignFirstResponder()
        }
        return true
        
}

}

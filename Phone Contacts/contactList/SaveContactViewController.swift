//
//  SecondViewController.swift
//  contactList
//
//  Created by Luis Castillo on 12/31/15.
//  Copyright © 2015 Luis Castillo. All rights reserved.
//

import UIKit

import Contacts

class SaveContactViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var homePhone: UITextField!
    
    @IBOutlet weak var addressStreet: UITextField!
    
    @IBOutlet weak var addressCity: UITextField!
    
    @IBOutlet weak var addressState: UITextField!
    
    @IBOutlet weak var addressZipCode: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var workEmail: UITextField!
    
    @IBOutlet weak var dateOfBirth: UITextField!
    
    var DOB:NSDateComponents = NSDateComponents()
    let dobPicker = UIDatePicker()
    
    //MARK: View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.toolbarHidden = true
        
        self.setUpDOBPicker()
        
    }//eom
    
    
    override func viewDidAppear(animated: Bool)
    {
        self.navigationController?.toolbarHidden = false
    }//eom


    //MARK: Saving A Contact
    
    @IBAction func saveContact(sender: AnyObject)
    {
        if self.isContactReadyToBeSaved()
        {
            self.saveAContact()
        }
        else
        {
            
        }
        
    }//eo-a
    
    func isContactReadyToBeSaved()-> Bool
    {
        //required fields:
        //  email
        //  phone
        //  first name
        //  last name
        
        
        
        return true
    }//eom
    
    
    func saveAContact()
    {
        // Creating a mutable object to add to the contact
        let contact = CNMutableContact()
        
        //image
        let userImage = imageView.image
        let userImageData = UIImageJPEGRepresentation(userImage!, 1)
        contact.imageData = userImageData
        
        //name
        contact.givenName   =  firstName.text!
        contact.familyName  =  lastName.text!
        
        //emails
        let userHomeEmail = CNLabeledValue(label:CNLabelHome, value:email.text!)
        let userWorkEmail = CNLabeledValue(label:CNLabelWork, value:workEmail.text!)
        contact.emailAddresses = [userHomeEmail, userWorkEmail]
        
        //phone numbers
        contact.phoneNumbers = [CNLabeledValue(
            label:CNLabelPhoneNumberiPhone,
            value:CNPhoneNumber(stringValue: self.homePhone.text! ))]
        
        //addresses
        let homeAddress = CNMutablePostalAddress()
        homeAddress.street = self.addressStreet.text!
        homeAddress.city = self.addressCity.text!
        homeAddress.state = self.addressState.text!
        homeAddress.postalCode = self.addressZipCode.text!
        contact.postalAddresses = [CNLabeledValue(label:CNLabelHome, value:homeAddress)]
        
        //date of birthday
//        let birthday = NSDateComponents()
//        birthday.day = 1
//        birthday.month = 4
//        birthday.year = 1988  // You can omit the year value for a yearless birthday
//
        contact.birthday = self.DOB
        
        // Saving the newly created contact
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.addContact(contact, toContainerWithIdentifier:nil)
        
        do
        {
            try store.executeSaveRequest(saveRequest)
        }
        catch {
            print("un-able to store contact")
        }
        
    }//eom
    
    
    //MARK: Camera
    
    
    //MARK:
    
    
    //MARK: Date Picker
    func setUpDOBPicker()
    {
        //picker set up
        dobPicker.datePickerMode = UIDatePickerMode.Date
        
        
        
        
        dateOfBirth.inputAccessoryView = dobPicker
        
    }//eom
    
    
    //MARK: TextField Delegates
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        
        if textField == firstName
        {
            lastName .becomeFirstResponder()
        }
        else if textField == lastName
        {
            homePhone .becomeFirstResponder()
        }
        else if textField == addressStreet
        {
            addressCity .becomeFirstResponder()
        }
        else if textField == addressCity
        {
            addressState .becomeFirstResponder()
        }
        else if textField == addressState
        {
            addressZipCode .becomeFirstResponder()
        }
        else if textField == addressZipCode
        {
            email .becomeFirstResponder()
        }
        else if textField == email
        {
            workEmail .becomeFirstResponder()
        }
        else if textField == workEmail
        {
            dateOfBirth .becomeFirstResponder()
        }
        
        return true
    }//eom
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.moveScrollview(textField)
    }//eom
    
    //MARK: Scrollview
    func moveScrollview(textfield: UITextField)
    {
    
    }//eom
    
    func resetScrollview()
    {
    
    }//eom
    
    //MARK: Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}


//
//  DatePickerInTextfieldViewController.swift
//  PickerView
//
//  Created by lu on 5/4/17.
//  Copyright © 2017 lu. All rights reserved.
//

import UIKit

class DatePickerInTextfieldViewController: UIViewController {
    
    //MARK: - UI Properties
    @IBOutlet weak var dateTextfield: UITextField!
    
    //MARK: - Properties
    fileprivate let datePicker:UIDatePicker = UIDatePicker()
    fileprivate var dateSelected:Date? = nil
    fileprivate let dateFormatter:DateFormatter = DateFormatter()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
        setupPicker()
    }
}

//MARK: -
extension DatePickerInTextfieldViewController{
    func setupDatePicker(){
        datePicker.setDate(Date(), animated: false)
        dateTextfield.inputView = datePicker
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
    }
    
    func setupPicker(){
        datePicker.contentMode      = .center
        datePicker.backgroundColor  = UIColor.lightGray
        datePicker.tintColor        = UIColor.black
        
        let toolBar = UIToolbar(frame: CGRect(x: 0,
                                              y: self.view.frame.size.height/6,
                                              width: self.view.frame.size.width,
                                              height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2,
                                         y: self.view.frame.size.height-20)
        toolBar.barStyle        = UIBarStyle.default
        toolBar.tintColor       = UIColor.black
        toolBar.backgroundColor = UIColor.white
        
        //options
        let cancelButton = UIBarButtonItem(title: "Cancel",
                                           style: UIBarButtonItemStyle.plain,
                                           target: self,
                                           action: #selector(cancelButtonPressed))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace,
                                        target: self,
                                        action: nil)
        
        //label
        let label = UILabel(frame: CGRect(x: 0,
                                          y: 0,
                                          width: self.view.frame.size.width/3,
                                          height: self.view.frame.size.height))
        label.font              = UIFont(name: "Helvetica-Bold", size: 14)
        label.backgroundColor   = UIColor.clear
        label.textColor         = UIColor.black
        label.text              = "Pick a Date"
        label.textAlignment     = NSTextAlignment.center
        let textBtn             = UIBarButtonItem(customView: label)
        
        //done
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done,
                                         target: self,
                                         action: #selector(doneButtonPressed))
        
        let items = [cancelButton,flexSpace,textBtn,flexSpace,doneButton]
        toolBar.setItems(items,
                         animated: true)
        
        dateTextfield.inputAccessoryView = toolBar
    }
    
    //MARK:  Helper
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


//MARK: - Actions
extension DatePickerInTextfieldViewController{
    func doneButtonPressed(_ sender: UIBarButtonItem) {
        dateSelected = datePicker.date
        dateTextfield.text = dateFormatter.string(from: datePicker.date)
        
        dateTextfield.resignFirstResponder()
    }
    
    func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dateTextfield.text = ""
        dateTextfield.resignFirstResponder()
    }
}

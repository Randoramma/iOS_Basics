//
//  DatePickerViewController.swift
//  PickerView
//
//  Created by lu on 5/4/17.
//  Copyright © 2017 lu. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    //MARK: - UI properties
    @IBOutlet weak var dateLabel:UILabel!
    @IBOutlet weak var datepicker: UIDatePicker!
    
    //MARK: - properties
    var dateSelected:Date? = nil
    fileprivate let dateFormatter:DateFormatter = DateFormatter()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
    }
    @IBAction func dateValueChanged(_ sender: UIDatePicker) {
        dateSelected = sender.date
        let stringDate = dateFormatter.string(from: sender.date)
        dateLabel.text = stringDate
    }
}

//MARK: - DatePicker
extension DatePickerViewController{
    fileprivate func setupDatePicker(){
        datepicker.setDate(Date(), animated: false)
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
    }
}

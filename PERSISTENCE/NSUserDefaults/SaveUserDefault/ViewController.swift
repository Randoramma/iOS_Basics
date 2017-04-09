//
//  ViewController.swift
//  SaveUserDefault
//
//  Created by lc on 11/23/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var saveAppButton: UIButton!
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var myDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.myLabel.text = ""
        
        self.loadUserData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadUserData()
    {
        let userDataSaved:UserDefaults = UserDefaults.standard
        let isSaved:Bool = userDataSaved .bool(forKey: "save")
        if(isSaved == false)
        {
            self.myLabel.text  = "app was not saved"
        }
        else
        {
            //loading data
            if let textData = userDataSaved .object(forKey: "textView")
            {
                myTextView.text = textData as! String
            }
            
            if let dateData = userDataSaved .object(forKey: "date")
            {
                myDatePicker.date = dateData as! Date
            }
            
            self.myLabel.text  = "app was saved"
        }
    }//eom
    
    @IBAction func saveApp(_ sender: AnyObject) {
        self.saveUserData()
    }//eo-a
    
    
    func saveUserData()
    {
        let saveAppData:UserDefaults = UserDefaults.standard
        
        saveAppData .set(true, forKey: "save")
        
        //getting data to save
        let textViewData = myTextView.text
        let datePicked = myDatePicker.date
        
        //adding data to save
        saveAppData .set(textViewData, forKey: "textView")
        saveAppData .set(datePicked, forKey: "date")
        
        //saving data
        saveAppData .synchronize()
        
        self.myLabel.text  = "app has been saved"
    }//eom

    
    /* disables editing on UITextView upon entering enter */
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n"
        {
            textView .resignFirstResponder()
            
            return false
        }
        
        return true
        
    }//eom
    
}


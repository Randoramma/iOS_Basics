//
//  ViewController.swift
//  coredata_cars
//
//  Created by Luis Andres Castillo Hernandez on 11/20/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import UIKit
import CoreData

class addCarViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var carMakeTextField: UITextField!
    @IBOutlet weak var carModelTextField: UITextField!
    @IBOutlet weak var carYearTextField: UITextField!
    
    
    var carmake: String     = ""
    var carmodel: String    = ""
    var caryear: String     = ""
    
    var existingItem: NSManagedObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //updating existing entry
        if(existingItem != nil)
        {
            carMakeTextField.text   = carmake
            carModelTextField.text  = carmodel
            carYearTextField.text   = caryear
        }
        
    }//ep

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Actions
    
    @IBAction func saveCarInfo(_ sender: AnyObject)
    {
        self.savedData()
    }//eoa

    
    //MARK: save
    func savedData()
    {
        let AppDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let theContext: NSManagedObjectContext = AppDel.managedObjectContext
        
        let theEnt = NSEntityDescription.entity(forEntityName: "CarList", in: theContext)
                
        //updating existing entry
        if(existingItem != nil)
        {
            let currCarMake     = carMakeTextField.text
            let currCarModel    = carModelTextField.text
            let currCarYear     = carYearTextField.text
            
            existingItem.setValue(currCarMake, forKey: "carMake")
            existingItem.setValue(currCarModel, forKey: "carModel")
            existingItem.setValue(currCarYear, forKey: "carYear")
        }
            //saving new entry
        else
        {
            let newitem = carModel(entity: theEnt!, insertInto: theContext)
            
            newitem.carMake     = carMakeTextField.text!
            newitem.carModel    = carModelTextField.text!
            newitem.carYear     = carYearTextField.text!
        }
        
        //going back to main view
        self.navigationController?.popViewController(animated: true)

    }//eom
    
    //MARK: textfield delegates
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        textField.resignFirstResponder()
    }//eom
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        if(textField == carMakeTextField)
        {
            carModelTextField.becomeFirstResponder()
        }
        else if (textField == carModelTextField)
        {
            carYearTextField.becomeFirstResponder()
        }
        else if (textField == carYearTextField)
        {
            self.savedData()
        }
        
        
        return true
    }//eom
    
}//eoc


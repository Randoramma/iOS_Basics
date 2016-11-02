//
//  ViewController.swift
//  alertview
//
//  Created by Luis Andres Castillo Hernandez on 11/15/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    //MARK: Views
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }//eo-view

    override func viewWillAppear(_ animated: Bool) {
        

    }//eo-view
    
    
    //MARK: actions
    
    @IBAction func showMeAlertView(_ sender: AnyObject)
    {
        self.displayAlertView("My Alert View", messageProvided: "Hi I am an Alert View")
    }//eo-a
    
    
    @IBAction func showMeAlertSheet(_ sender: AnyObject)
    {
        self.displayAlertSheet("My Alert Sheet", messageProvided: "Hi I am an Alert Sheet")
    }//eo-a
    
    //MARK: Alert view
    
    func displayAlertView(_ titleProvided:String, messageProvided:String)
    {
        //creating controller
        let actionController:UIAlertController = UIAlertController(title: titleProvided, message: messageProvided, preferredStyle: UIAlertControllerStyle.alert)
        
        
        //creating actions
        let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel Action", style: UIAlertActionStyle.cancel)
        { action -> Void in
            print("[alert view] Cancel action!")
        }
        
        let defaultAction:UIAlertAction = UIAlertAction(title: "Default Action", style: UIAlertActionStyle.default)
            { action -> Void in
                print("[alert view] Default action!")
        }
        
        let destructiveAction:UIAlertAction = UIAlertAction(title: "Destructive Action", style: UIAlertActionStyle.destructive)
            { action -> Void in
                print("[alert view] Destructive action!")
        }
        
        //adding actions to alert controller
        actionController.addAction(cancelAction)
        actionController.addAction(defaultAction)
        actionController.addAction(destructiveAction)
        
        //adding a text field
        actionController.addTextField
        {
            textfield -> Void in
            
            //textfield configuration
            textfield.placeholder = "Type something I dont bite :)"
            textfield.textColor = UIColor.gray
        
        }
        
        //presenting alert
        self.present(actionController, animated: true, completion: nil)
        
    }//eom
    
    //MARK: Alert sheet
    func displayAlertSheet(_ titleProvided:String, messageProvided:String)
    {
        //creating controller
        let actionController = UIAlertController(title: titleProvided, message: messageProvided, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        //creating actions
        let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel Action", style: UIAlertActionStyle.cancel)
            { action -> Void in
                print("[alert sheet] Cancel action!")
        }
        
        let defaultAction:UIAlertAction = UIAlertAction(title: "Default Action", style: UIAlertActionStyle.default)
            { action -> Void in
                print("[alert sheet] Default action!")
        }
        
        let destructiveAction:UIAlertAction = UIAlertAction(title: "Destructive Action", style: UIAlertActionStyle.destructive)
            { action -> Void in
                print("[alert sheet] Destructive action!")
        }
        
        //adding actions to alert controller
        actionController.addAction(cancelAction)
        actionController.addAction(defaultAction)
        actionController.addAction(destructiveAction)
        
        
        //presenting alert
        self.present(actionController, animated: true, completion: nil)
        
    }//eom
    
    //MARK: Memory
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}//eoc


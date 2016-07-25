//
//  ViewController.swift
//  singletonClass
//
//  Created by Luis Andres Castillo Hernandez on 11/17/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewDidAppear(animated: Bool)
    {
        // Do any additional setup after loading the view, typically from a nib.
  
        let firstModel      = SharedUser.singletonInstance
        let secondModel     = SharedUser.singletonInstance
        
        firstModel.updateEmail("myEmail@me.com")
        firstModel.updateUsername("coolUsername")
        
        print("1st: \(firstModel.displayUserInfo())\n")
    
        print("2nd: \(secondModel.displayUserInfo())\n")
    }//eo-view
    
    
    
    
}//eoc


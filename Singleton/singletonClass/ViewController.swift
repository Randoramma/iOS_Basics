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
    
    override func viewDidAppear(_ animated: Bool)
    {
        // Do any additional setup after loading the view, typically from a nib.
  
        let firstModel:AppModel      = AppModel.sharedInstance
        let secondModel:AppModel     = AppModel.sharedInstance
        
        firstModel.updateName("Cool App")
        firstModel.updateNumber("927844")
        
        secondModel.updateName("Awesome App")
        
        firstModel.debug()
        secondModel.debug()
    }//eo-view
    
    
    
    
}//eoc


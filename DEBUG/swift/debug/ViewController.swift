//
//  ViewController.swift
//  debug
//
//  Created by Luis Castillo on 10/1/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        #if DEBUG
            print("Debug mode")
            self.view.backgroundColor = UIColor.red
        #else
            print("Regular mode")
            self.view.backgroundColor = UIColor.green
        #endif
    }//eom

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  Indicators
//
//  Created by Luis Andres Castillo Hernandez on 11/22/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }


    @IBAction func startIndicator(_ sender: AnyObject) {
        self.indicator.startAnimating()
        self.indicator.hidesWhenStopped = true
    }

    @IBAction func stopIndicator(_ sender: AnyObject) {
        self.indicator.stopAnimating()
    }
}


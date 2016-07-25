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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startIndicator(sender: AnyObject) {
        
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
    }

    @IBAction func stopIndicator(sender: AnyObject) {
        
        indicator.stopAnimating()
    }
}


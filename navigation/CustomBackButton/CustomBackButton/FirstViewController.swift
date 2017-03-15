//
//  ViewController.swift
//  CustomBackButton
//
//  Created by Luis Castillo on 3/14/17.
//  Copyright © 2017 lc. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.performSegue(withIdentifier: "showNextView", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


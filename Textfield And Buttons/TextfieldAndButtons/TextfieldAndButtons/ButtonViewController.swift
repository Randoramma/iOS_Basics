//
//  ViewController.swift
//  TextfieldAndButtons
//
//  Created by Luis Castillo on 11/1/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class ButtonViewController: UIViewController {

    
    @IBOutlet weak var rectangleButton: UIButton!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottonButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var roundButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        topButton.addTopBorder(color: UIColor.green, borderWidth: 2.5)
        bottonButton.addBottomBorder(color: UIColor.red, borderWidth: 2.5)
        leftButton.addLeftBorder(color: UIColor.orange, borderWidth: 1.5)
        rightButton.addRightBorder(color: UIColor.cyan, borderWidth: 1.5)
        
        rectangleButton.addBorder(color: UIColor.brown, borderWidth: 2.0)
        roundButton.addRoundBorder(color: UIColor.blue, borderWidth: 1.4)
    }
   
}


//
//  ViewController.swift
//  SpeechSynthesizer
//
//  Created by Luis Castillo on 5/31/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let speech:SpeechSynthesizer = SpeechSynthesizer.sharedInstance
    
    @IBOutlet weak var textTospeakTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func speakTextNow(_ sender:UIButton)
    {
        let textToSpeak:String = textTospeakTextView.text
        speech.speakText(textToSpeak)
        
    }//eo-a

}//eoc


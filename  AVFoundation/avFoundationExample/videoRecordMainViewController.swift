//
//  videoRecordMainViewController.swift
//  avFoundationExample
//
//  Created by Luis Castillo on 2/10/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class videoRecordMainViewController: UIViewController
{
    @IBOutlet weak var startRecordingButton: UIButton!
    
    //MARK: View Loading
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }//eom
    
    override func viewDidAppear(animated: Bool)
    {
        
    }//eom
    
    override func viewDidDisappear(animated: Bool)
    {
        
    }//eom
    
    @IBAction func recordVideo(sender: UIButton)
    {
        let videoVC:VideoMakerViewController = VideoMakerViewController()
        
        self.presentViewController(videoVC, animated: true) { () -> Void in
            
        }
    }//eo-a
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
    }//eom
    
    //MARK: Memory
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//eom
    
}//eoc
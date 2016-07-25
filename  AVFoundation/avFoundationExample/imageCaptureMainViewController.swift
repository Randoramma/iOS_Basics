//
//  imageCaptureMainViewController.swift
//  avFoundationExample
//
//  Created by Luis Castillo on 2/11/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class imageCaptureMainViewController: UIViewController {

    
    //MARK: View Loading
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }//eom
    
    
    @IBAction func takePicture(sender: AnyObject)
    {
        let vc:imageCaptureViewController = imageCaptureViewController()
        
        self.presentViewController(vc, animated: true) { () -> Void in
            
        }
        
    }//eo-a
    
    //MARK: Memory
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }//eom
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
    }//eom

}

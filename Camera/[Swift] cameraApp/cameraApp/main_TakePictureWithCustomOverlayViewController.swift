//
//  main_TakePictureWithCustomOverlayViewController.swift
//  cameraApp
//
//  Created by Luis Castillo on 2/21/16.
//  Copyright © 2016 devbros. All rights reserved.
//

import UIKit

class main_TakePictureWithCustomOverlayViewController: UIViewController
{
    
    //MARK: View Loading
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }//eom

    //MARK:
    @IBAction func showCamera(sender: AnyObject)
    {
        let vc:TakePictureWithCustomOverlayViewController = TakePictureWithCustomOverlayViewController()
        
        self.presentViewController(vc, animated: true, completion: nil)
    }//eo-a
    
    
    
    
    //MARK: Memory
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }//eom
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }

}

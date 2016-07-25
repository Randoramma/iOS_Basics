//
//  ViewController.swift
//  webInteractions
//
//  Created by Luis Castillo on 3/10/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController,SFSafariViewControllerDelegate {

    
    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    // MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//eo-m
    

    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "goToCustomWebView"
        {
            
        }
    }//eo-m


    @IBAction func showSafari(sender: AnyObject)
    {
        let url:NSURL = NSURL(string: amazon)!
        UIApplication.sharedApplication().openURL(url)
    }//eo-a
    
    
    
    
    @IBAction func showCustomWebView(sender: AnyObject)
    {
        self.performSegueWithIdentifier("goToCustomWebView", sender: nil)
    }//eo-a
    
    
    
    
    @IBAction func showSafariController(sender: AnyObject)
    {
        let url:NSURL = NSURL(string: amazon)!
        
        let safariVC = SFSafariViewController(URL: url)
        safariVC.delegate = self
        self.presentViewController(safariVC, animated: true, completion: nil)
    }//eo-a
    
    
    
    //MARK: - Safari Delegates
    //    func safariViewController(controller: SFSafariViewController, activityItemsForURL URL: NSURL, title: String?) -> [UIActivity]
    //    {
    //
    //        print("activityItemsForURL")
    //        print(controller.debugDescription)
    //    }//eom
    
    
    func safariViewController(controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool)
    {
        print("didCompleteInitialLoad")
        print(controller.debugDescription)
        
    }//eom
    
    func safariViewControllerDidFinish(controller: SFSafariViewController)
    {
        print("safariViewControllerDidFinish")
        print(controller.debugDescription)
        
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }//eom

    
}

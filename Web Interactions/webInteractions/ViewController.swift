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
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
    }//eo-m


    @IBAction func showSafari(_ sender: AnyObject)
    {
        let url:URL = URL(string: amazon)!
        UIApplication.shared.openURL(url)
    }//eo-a
    
    
    
    
    @IBAction func showCustomWebView(_ sender: AnyObject)
    {
        self.performSegue(withIdentifier: "goToCustomWebView", sender: nil)
    }//eo-a
    
    
    
    
    @IBAction func showSafariController(_ sender: AnyObject)
    {
        let url:URL = URL(string: amazon)!
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        self.present(safariVC, animated: true, completion: nil)
    }//eo-a
    
    
    
    //MARK: - Safari Delegates
    //    func safariViewController(controller: SFSafariViewController, activityItemsForURL URL: NSURL, title: String?) -> [UIActivity]
    //    {
    //
    //        print("activityItemsForURL")
    //        print(controller.debugDescription)
    //    }//eom
    
    
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool)
    {
        print("didCompleteInitialLoad")
        print(controller.debugDescription)
        
    }//eom
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController)
    {
        print("safariViewControllerDidFinish")
        print(controller.debugDescription)
        
        controller.dismiss(animated: true, completion: nil)
        
    }//eom

    
}

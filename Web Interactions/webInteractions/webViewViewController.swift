//
//  webViewViewController.swift
//  webInteractions
//
//  Created by Luis Castillo on 3/10/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit
import WebKit

class webViewViewController: UIViewController, UIWebViewDelegate
{

    @IBOutlet weak var webAddressLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var doneButton: UIButton!
    
    
    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupWebView()
    }//eom
    
    
    // MARK: - Memory
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    //MARK: Webview
    func setupWebView()
    {
        self.webAddressLabel.text = amazon
        
        let url:NSURL               = NSURL(string: amazon)!
        let urlRequest:NSURLRequest = NSURLRequest(URL: url)
        
        self.webView.loadRequest(urlRequest)
    }//eo-a
    
    
    
    @IBAction func closeWebView(sender:AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }//eo-a
    
    
    //MARK: Webview Delegates
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print(" ")
        print("didFailLoadWithError")
        print(error?.localizedDescription)
    }//eom
    
    
    func webView(webView: UIWebView,
        shouldStartLoadWithRequest request: NSURLRequest,
        navigationType: UIWebViewNavigationType) -> Bool
    {
        print(" ")
        print("shouldStartLoadWithRequest")
        print(request.debugDescription)
        print("nav type: \(navigationType)")
        
        return true
    }//eom
    
    
    func webViewDidFinishLoad(webView: UIWebView)
    {
        print(" ")
        print("webViewDidFinishLoad")
        print("\(webView.debugDescription)")
    }//eom
    
    func webViewDidStartLoad(webView: UIWebView)
    {
        print(" ")
        print("webViewDidStartLoad")
        print("\(webView.debugDescription)")
    }//eom
}

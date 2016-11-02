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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    //MARK: Webview
    func setupWebView()
    {
        self.webAddressLabel.text = amazon
        
        let url:URL               = URL(string: amazon)!
        let urlRequest:URLRequest = URLRequest(url: url)
        
        self.webView.loadRequest(urlRequest)
    }//eo-a
    
    
    
    @IBAction func closeWebView(_ sender:AnyObject)
    {
        self.dismiss(animated: true, completion: nil)
    }//eo-a
    
    
    //MARK: Webview Delegates
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(" ")
        print("didFailLoadWithError")
        print(error.localizedDescription)
    }//eom
    
    
    func webView(_ webView: UIWebView,
        shouldStartLoadWith request: URLRequest,
        navigationType: UIWebViewNavigationType) -> Bool
    {
        print(" ")
        print("shouldStartLoadWithRequest")
        print(request.debugDescription)
        print("nav type: \(navigationType)")
        
        return true
    }//eom
    
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        print(" ")
        print("webViewDidFinishLoad")
        print("\(webView.debugDescription)")
    }//eom
    
    func webViewDidStartLoad(_ webView: UIWebView)
    {
        print(" ")
        print("webViewDidStartLoad")
        print("\(webView.debugDescription)")
    }//eom
}

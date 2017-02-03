//
//  ViewController.swift
//  Labels
//
//  Created by Luis Castillo on 11/27/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class KILabelViewController: UIViewController
{
    @IBOutlet weak var labelOne: KILabel!
    @IBOutlet weak var labelTwo: KILabel!
    @IBOutlet weak var labelThree: KILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         // Attach a block to be called when the user taps a user handle
         label.userHandleLinkTapHandler = { label, handle, range in
         print("User handle \(handle) tapped")
         }
         
         // Attach a block to be called when the user taps a hashtag
         label.hashtagLinkTapHandler = { label, hashtag, range in
         print("Hashtah \(hashtag) tapped")
         }
         
         // Attach a block to be called when the user taps a URL
         label.urlLinkTapHandler = { label, url, range in
         print("URL \(url) tapped")
         }
         */
        
        labelOne.systemURLStyle = true
        labelTwo.systemURLStyle = true
        labelThree.systemURLStyle = true
        
        //with http
        labelOne.urlLinkTapHandler = { label, urlString, range in
            print("URL \(urlString) tapped")
            self.attemptToOpenURL(url: URL(string: urlString) )
        }
        
        //without http, but www ,com
        labelTwo.urlLinkTapHandler = { label, urlString, range in
            print("URL \(urlString) tapped")
            let url:String = "http://".appending(urlString)
            self.attemptToOpenURL(url: URL(string: url) )
        }
        
        //without http, www
        labelThree.urlLinkTapHandler = { label, urlString, range in
            print("URL \(urlString) tapped")
            let url:String = "http://www.".appending(urlString)
            self.attemptToOpenURL(url: URL(string: url) )
        }
    }//eom

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: - HELPERS
    func attemptToOpenURL(url:URL?)
    {
        guard let urlProvided:URL = url else
        {
            print("invalid url \(url)")
            return
        }
        
        UIApplication.shared.open(urlProvided, options: [:], completionHandler: nil)
    }//eom

}


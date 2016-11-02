//
//  ViewController.swift
//  sendSMS
//
//  Created by Luis Castillo on 1/16/16.
//  Copyright © 2016 DevBros. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate
{
    
    
    //MARK: - View Loading
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }//eom
    
    override func viewDidAppear(_ animated: Bool) {
        
    }//eom
    
    
    //MARK: -
    func sendSMS()
    {
        let smsComposer:MFMessageComposeViewController = MFMessageComposeViewController()
    
        smsComposer.messageComposeDelegate = self
        
        if MFMessageComposeViewController .canSendText()
        {
            let recipients:[String] = ["111-222-3321","391-221-2091"]
            
            //recipients
            smsComposer.recipients = recipients
            
            //subject
            smsComposer.subject = "subject goes here"
            
            //body
            smsComposer.body = "Hey there it's me!"
            
            //attachments
            //smsComposer.addAttachmentData(<#T##attachmentData: NSData##NSData#>, typeIdentifier: <#T##String#>, filename: <#T##String#>)
            
            //presenting message
            self .present(smsComposer, animated: true, completion: { () -> Void in
                
            })
        }
        else
        {
            print("????")
        }
    }//eom

    
    
    //MARK: - SMS Delegates
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    {
        switch result
        {
        case MessageComposeResult.cancelled:
            print("message Cancelled")
            break
        case MessageComposeResult.failed:
            print("message failed")
            break
        case MessageComposeResult.sent:
            print("message sent")
            break
        default :
            print("unknown message occurred")
            break
        }
        
        self.dismiss(animated: true) { () -> Void in
            
        }
        
    }//eom
    
    
    @IBAction func sendMessage(_ sender: AnyObject)
    {
        self.sendSMS()
    }//eo-a
    
    
    
    //MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


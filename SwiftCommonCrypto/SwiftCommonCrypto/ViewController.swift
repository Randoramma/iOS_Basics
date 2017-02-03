//
//  ViewController.swift
//  SwiftCommonCrypto
//
//  Created by Luis Castillo on 1/21/17.
//  Copyright © 2017 lc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: - Password
    func hashPassword( saltPassword:String )->String?
    {
        var hashedPassword:String? = nil
        let hashPasswordData:UnsafeMutablePointer<UInt8>? = nil
        
        if let passwordData:NSData = saltPassword.data(using: String.Encoding.utf8) as NSData?
        {
            if (CC_SHA1(passwordData.bytes,
                        CC_LONG(passwordData.length),
                        hashPasswordData) != nil)
            {
                if hashPasswordData != nil
                {
                    hashedPassword = NSString(bytes: hashPasswordData!,
                                              length: MemoryLayout.size(ofValue: hashPasswordData!),
                                              encoding: String.Encoding.ascii.rawValue) as? String
                    
                }
            }
        }
        
        return hashedPassword
    }//eom
    
    /*
        calculating an SHA1 HMAC
    */
    func hmac_sha1(data: NSData, key: NSData) -> (NSData?) {
        let result = NSMutableData(length: Int(CC_SHA1_DIGEST_LENGTH))
        if (result != nil) {
            CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1),
                   key.bytes, size_t(key.length),
                   data.bytes, size_t(data.length),
                   result!.mutableBytes)
        }
        return result
    }
    
    
    
}


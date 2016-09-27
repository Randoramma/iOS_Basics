//
//  CheckOSOversion.swift
//  OSVersion
//
//  Created by Luis Castillo on 9/26/16.
//  Copyright © 2016 LC. All rights reserved.
//

import Foundation

@objc class CheckOSOversion:NSObject {
    
    
    
    func checkVersion()
    {
        let osSystem:OperatingSystemVersion = (ProcessInfo .processInfo) .operatingSystemVersion;
       
        let osString = (ProcessInfo .processInfo) .operatingSystemVersionString
        let osMin:Int = osSystem.minorVersion
        let osMax:Int = osSystem.minorVersion
        
        var printString = "Swift info: \n"
        printString = "\(printString)  OS (Max.Min) = \(osMax).\(osMin) \n"
        printString = "\(printString)  \(osString)"
        
        print("\(printString) \n\n")
        
        
        if #available(iOS 10, *) {
            print("ios 10!")
        }
        else if #available(iOS 9.3, *) {
            print("ios 9.3!")
        }
        else if #available(iOS 8, *) {
            print("ios 8!")
        }
        
    }//eom
}

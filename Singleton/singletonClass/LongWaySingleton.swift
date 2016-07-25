//
//  LongWaySingleton.swift
//  singletonClass
//
//  Created by Luis Andres Castillo Hernandez on 11/17/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import Foundation


class LongWaySingleton {
    
    
    class func sharedInstance() -> LongWaySingleton!
    {
        struct Static {
            static var instance: LongWaySingleton? = nil
            static var onceToken: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.onceToken) {
            Static.instance = self.init()
        }
        
        return Static.instance!
    }//eo-shared instance
    
    
    required init()
    {

    }//eo init
    
}
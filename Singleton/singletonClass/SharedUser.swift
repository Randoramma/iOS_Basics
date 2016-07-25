//
//  File.swift
//  singletonClass
//
//  Created by Luis Andres Castillo Hernandez on 11/17/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import Foundation

class SharedUser {
    
    //singleton one way
    static let singletonInstance =  User()
    
    //singleton another way
    //    class var sharedInstance: User {
    //        struct Static {
    //            static let instance: User = User()
    //        }
    //        return Static.instance
    //    }
    
}//eoc
//
//  User.swift
//  singletonClass
//
//  Created by Luis Andres Castillo Hernandez on 11/17/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import Foundation

class User {
    
    //vars
     private var username:String
     private var email:String
    
    
    init()
    {
        self.email       = String()
        self.username    = String()
    }
    
    func updateUsername(usernameProvided:String)
    {
        self.username = usernameProvided
    }//eom
    
    func updateEmail(emailProvided:String)
    {
        self.email = emailProvided
    }//eom
    
    func displayUserInfo()
    {
        print("Email:       \(email)");
        print("Username:    \(username)");
    }//eom
    
}//eom
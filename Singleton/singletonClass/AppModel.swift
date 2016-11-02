//
//  User.swift
//  singletonClass
//
//  Created by Luis Andres Castillo Hernandez on 11/17/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import Foundation

class AppModel {
    
    static let sharedInstance:AppModel = AppModel()
    
    //vars
     fileprivate var _modelName:String = "Model"
     fileprivate var _modelNumber:String = "000000"
    
    
    func updateName(_ name:String)
    {
        self._modelName = name
    }//eom
    
    func updateNumber(_ number:String)
    {
        self._modelNumber = number
    }//eom
    
    
    func debug()
    {
        print("\n")
        print("modelName:      \(_modelName)");
        print("modelNumber:    \(_modelNumber)");
        print("\n")
    }//eom
    
}//eom

//
//  mySwiftClass.swift
//  UseSwiftWithObjectiveC
//
//  Created by Luis Castillo.
//  Copyright © 2016 DevBros. All rights reserved.
//

import Foundation

@objc class mySwiftClass:NSObject
{
    private var _name:String
    private var _age:String
    var desc:String = "Its Swift!"
    
    convenience init(name:String, age:String)
    {
        self.init()
        
        _name = name
        _age = age
    }
    
    
    override init()
    {
        _name = ""
        _age = ""
    }
    
    func debug()
    {
        print("name:    \(_name)")
        print("age:     \(_age)")
    }
    
    func callObjectiveC()
    {
        let objectiveC:myObjectiveCClass = myObjectiveCClass()
        
        objectiveC.bookTitle = "Final Round"
        
        objectiveC .debug()
        
    }//eom
}//eoc
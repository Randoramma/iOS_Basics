//
//  MyCustomOperation.swift
//  NSOperations
//
//  Created by Luis Castillo on 3/20/16.
//  Copyright © 2016 DevBros. All rights reserved.
//

import Foundation

class MyCustomOperation: Operation
{
    var running:Bool = false
    var didFinished:Bool = false
    
    override func main()
    {
        if self.isCancelled
        {
            return
        }
        else
        {
            NSLog("custom operation work is done here.")
            for i in 0..<5
            {
                NSLog("i%d",i)
                sleep(1)
            }//eofl
        }
        
        self.willChangeValue(forKey: "executing")
        running = false
        self.didChangeValue(forKey: "executing")
        
        self.willChangeValue(forKey: "finished")
        didFinished = true
        self.didChangeValue(forKey: "finished")
        
        if(didFinished)
        {
            NSLog("completed")
        }
        else
        {
            NSLog("Not completed")
        }
    }//eom
    
}//eoc

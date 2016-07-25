//
//  MyCustomOperation.swift
//  NSOperations
//
//  Created by Luis Castillo on 3/20/16.
//  Copyright © 2016 DevBros. All rights reserved.
//

import Foundation

class MyCustomOperation: NSOperation
{
    var running:Bool = false
    var didFinished:Bool = false
    
    override func main()
    {
        if self.cancelled
        {
            return
        }
        else
        {
            NSLog("custom operation work is done here.")
            for (var i = 0; i<5; i++)
            {
                NSLog("i%d",i)
                sleep(1)
            }//eofl
        }
        
        self.willChangeValueForKey("executing")
        running = false
        self.didChangeValueForKey("executing")
        
        self.willChangeValueForKey("finished")
        didFinished = true
        self.didChangeValueForKey("finished")
        
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
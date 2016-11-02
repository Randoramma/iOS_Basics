//
//  ViewController.swift
//  NSOperations
//
//  Created by Luis Castillo on 3/20/16.
//  Copyright © 2016 DevBros. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    //MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - 
    @IBAction func exampleOne(_ sender: AnyObject)
    {
        self.blockOperationsTest1()
    }//eo-a

    @IBAction func exampleTwo(_ sender: AnyObject)
    {
        self.blockOperationsTest2()
    }//eo-a

    
    @IBAction func exampleThree(_ sender: AnyObject)
    {
          self.blockOperationsTest3()
    }//eo-a

    func blockOperationsTest1()
    {
        let operationQueue = OperationQueue()
        
        let operation1 : BlockOperation = BlockOperation (block:
            {
            
            NSLog("do Calculations")
            for i in 100...105
            {
                print("i in do calculations is \(i)")
                sleep(1)
            }//eofl
                
            let operation2 : BlockOperation = BlockOperation (block:
                {
                
                NSLog("do Some More Calculations")
                for j in 1...5
                {
                    print("j in do some more calculations is \(j)")
                    sleep(1)
                    }//eofl
            })
            
            operationQueue.addOperation(operation2)
        })
        operationQueue.addOperation(operation1)
    }//eom
    
    func blockOperationsTest2 ()
    {
        let operationQueue: OperationQueue = OperationQueue.main
        let completionBlockOperation: BlockOperation = BlockOperation.init(
            block: {
                print("completion Block is getting called")
            }
        )
        
        let workerBlockOperation:BlockOperation = BlockOperation.init(
            block:
            {
                print("worker block")
                print("Actual Worker Block")
                
                for i in 0..<5
                {
                    sleep(1)
                    print(i)
                }//eofl
                
            }
        )
        completionBlockOperation.addDependency(workerBlockOperation)
        operationQueue.addOperation(workerBlockOperation)
        operationQueue.addOperation(completionBlockOperation)
    }//eom
    
    
    func blockOperationsTest3 ()
    {
        let customOperation : MyCustomOperation = MyCustomOperation()
        customOperation.completionBlock =
            {
            print("Both the Block Operation and the Custom Operation is completed")
        }
        
        let workerBlockOperation:BlockOperation = BlockOperation.init(
            block: {
                print("Primary Worker block")
            }
        )
        customOperation.addDependency(workerBlockOperation)
        
        let operationQueue = OperationQueue.main
        operationQueue.addOperation(customOperation)
        operationQueue.addOperation(workerBlockOperation)
    
    }//eom
    
}//eoc


//
//  VCThatCallsPopOverViewController.swift
//  LoadingViews
//
//  Created by Luis Castillo on 1/1/16.
//  Copyright © 2016 devbros. All rights reserved.
//

import UIKit
import QuartzCore

class VCThatCallsPopOverViewControllerSwift: UIViewController {

    var popOverVC:PopOverViewControllerSwift!
    
    //MARK: View Loading
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }//eom

    //MARK: Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    //MARK: Show PopOver
    
    @IBAction func showPopOver(_ sender: AnyObject)
    {
        self.showPopView()
    }//eoa
   
    
    func showPopView()
    {
        self.popOverVC = PopOverViewControllerSwift(nibName: "PopOverViewController", bundle: nil)
        
        if navigationController != nil
        {
            let navBarHeight:CGFloat = self.navigationController!.navigationBar.frame.size.height
            let calcYOrigin:CGFloat = self.view.bounds.origin.y + navBarHeight + 1
            let calcHeight:CGFloat = self.view.bounds.size.height - navBarHeight - 1
            
            let popOverFrame = CGRect(x: self.view.bounds.origin.x,
                                      y: calcYOrigin,
                                      width: self.view.bounds.size.width,
                                      height: calcHeight)
            
            self.popOverVC.view.frame = popOverFrame
        }
        else
        {
            self.popOverVC.view.frame = self.view.bounds
        }
        
        
        self.popOverVC .showInView(self.view, animated: true)
    }//eom

}

//
//  VCThatCallsPopOverViewController.swift
//  LoadingViews
//
//  Created by Luis Castillo on 1/1/16.
//  Copyright © 2016 devbros. All rights reserved.
//

import UIKit
import QuartzCore

class VCThatCallsPopOverViewController: UIViewController {

    var popOverVC:PopOverViewController!
    
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    //MARK: Show PopOver
    
    @IBAction func showPopOver(sender: AnyObject)
    {
        //iPad
        if (UIDevice.currentDevice().userInterfaceIdiom == .Pad)
        {
            self.showPopViewForIpad()
        }//eo-ipad
        else
        {
            //iPhone 6 & iPhone6 Plus
            if UIScreen.mainScreen().bounds.size.width > 320
            {
                //iPhone6 Plus
                if UIScreen.mainScreen().scale == 3
                {
                    self.showPopViewForIphone6Plus()
                }
                //iPhone 6
                else
                {
                    self.showPopViewForIphone6()
                }
            }
            //iPhone 5s & below
            else
            {
                self.showPopViewForIphone5AndBelow()
            }
        }//eo-iphone
    }//eoa
   
    
    func showPopViewForIpad()
    {
        print("iPad")
        self.popOverVC = PopOverViewController(nibName: "PopOverViewController_iPad", bundle: nil)
        self.popOverVC .showInView(self.view, animated: true)
    }//eom
    
    
    func showPopViewForIphone6()
    {
        print("iPhone 6")
        self.popOverVC = PopOverViewController(nibName: "PopOverViewController_iPhone6", bundle: nil)
        self.popOverVC .showInView(self.view, animated: true)
        
    }//eom

    func showPopViewForIphone6Plus()
    {
        print("iPhone 6 Plus")
        self.popOverVC = PopOverViewController(nibName: "PopOverViewController_iPhone6Plus", bundle: nil)
        self.popOverVC .showInView(self.view, animated: true)
        
    }//eom

    func showPopViewForIphone5AndBelow()
    {
        print("Iphone5AndBelow")
        self.popOverVC = PopOverViewController(nibName: "PopOverViewController", bundle: nil)
        self.popOverVC .showInView(self.view, animated: true)
        
    }//eom


}

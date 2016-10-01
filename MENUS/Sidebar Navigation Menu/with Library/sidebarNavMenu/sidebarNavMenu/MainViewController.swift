//
//  MenuViewController.swift
//  sidebarNavMenu
//
//  Created by Luis Castillo on 8/13/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var openBarButton: UIBarButtonItem!
    
    @IBOutlet weak var label: UILabel!
    
    var varView:Int = 1
    
    //MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        openBarButton.target = self.revealViewController()
        openBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
        
        
        //show menu by sliding the screen
        //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }//eom
    
    //MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}

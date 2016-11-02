//
//  HomeViewController.swift
//  sidebarNavMenu
//
//  Created by Luis Castillo on 8/13/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var menuButton: UIButton!
    
    
    //MARK: -Views
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let revealSelector = #selector(SWRevealViewController.revealToggle(_:))
        
        self.menuButton.addTarget(self.revealViewController(), action: revealSelector, for: UIControlEvents.touchDown)
        
        
        //show menu by sliding the screen
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    //MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

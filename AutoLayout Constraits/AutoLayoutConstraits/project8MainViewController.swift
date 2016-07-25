//
//  project8MainViewController.swift
//  AutoLayoutConstraits
//
//  Created by Luis Castillo on 2/4/16.
//  Copyright © 2016 DevBros. All rights reserved.
//

import UIKit

class project8MainViewController: UIViewController {

    @IBOutlet weak var subView: UIView!
    
    // MARK: - View Loading
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.loadViewFromNib()
    }//eom
    
    override func viewDidAppear(animated: Bool)
    {
    }//eom
 
    func loadViewFromNib()
    {
        let nibController = Project8SubViewController()
        nibController.view.frame = subView.bounds
        
        subView.addSubview(nibController.view)
        
        addChildViewController(nibController)
        
        nibController.didMoveToParentViewController(self)
    }//eom

    
    // MARK: - Memory
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

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
    
    override func viewDidAppear(_ animated: Bool)
    {
    }//eom
 
    func loadViewFromNib()
    {
        let nibController = Project8SubViewController()
        nibController.view.frame = subView.bounds
        
        subView.addSubview(nibController.view)
        
        addChildViewController(nibController)
        
        nibController.didMove(toParentViewController: self)
    }//eom

    
    // MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}

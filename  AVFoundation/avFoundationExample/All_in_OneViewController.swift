//
//  All_in_OneViewController.swift
//  avFoundationExample
//
//  Created by Luis Castillo on 2/11/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class All_in_OneViewController: UIViewController {

    @IBOutlet weak var imageChoosen: UIImageView!
    
    // MARK: - View Loading
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }//eom

    @IBAction func showAllMedia(_ sender: AnyObject)
    {
        let vc:AllMediaViewController = AllMediaViewController()
        
        vc.optionSelected = 2
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.pushViewController(vc, animated: true)
    }//eo-a
    
    // MARK: - Memory
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//eom
    
    

}

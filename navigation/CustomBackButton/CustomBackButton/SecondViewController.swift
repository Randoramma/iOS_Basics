//
//  SecondViewController.swift
//  CustomBackButton
//
//  Created by Luis Castillo on 3/14/17.
//  Copyright © 2017 lc. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let newBackButton = UIBarButtonItem(title: "No",
                                            style: UIBarButtonItemStyle.plain, target: self, action:nil)
        self.navigationItem.setLeftBarButton(newBackButton, animated: false)
        
        let inserts = UIEdgeInsets(top: 0,
                                   left: -5,
                                   bottom: 0,
                                   right: 0)
        
        // Load the image centered
        let imgBackArrow = UIImage(named: "back-4")?.withAlignmentRectInsets(inserts)
        
        // Set the image
        self.navigationController?.navigationBar.backIndicatorImage = imgBackArrow
        
        // Set the image mask
        self.navigationController?.navigationBar
            .backIndicatorTransitionMaskImage = imgBackArrow
        
//        self.navigationController?.navigationBar.topItem.title = " ";
        print("title: ",self.navigationController?.navigationBar.topItem?.title ?? "none")
        print("title: ",self.navigationController?.navigationBar.backItem?.title ?? "none")
        print("")
        
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

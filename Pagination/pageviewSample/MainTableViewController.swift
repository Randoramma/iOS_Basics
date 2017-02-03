//
//  MainTableViewController.swift
//  pageviewSample
//
//  Created by Luis Castillo on 8/14/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

protocol OnboardingDelegate {
    func dismiss()
}

class MainTableViewController: UITableViewController, OnboardingDelegate {

    private var presentingOnboardVC:UIViewController? = nil
    
    //MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }//eom

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.setNavigationBarHidden(true, animated: false)
    }//eom

   
    //MARK: - Onboarding Delegate
    func dismiss() {
//        self.dismiss(animated: true, completion: nil)
         _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let basicVC:BasicViewController = segue.destination as? BasicViewController
        {
            presentingOnboardVC = basicVC
            basicVC.onboardingDelegate = self
        }
        else if let standardVC:StandardViewController = segue.destination as? StandardViewController
        {
            presentingOnboardVC = standardVC
            standardVC.onboardingDelegate = self
        }
    }//eom
    
    //MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//eom

}

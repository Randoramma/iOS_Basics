//
//  AViewController.swift
//  LoadingViews
//
//  Created by Luis Andres Castillo Hernandez on 11/20/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import UIKit

class AViewController: UIViewController {

    @IBOutlet weak var myUIView: UIView!
    
    @IBOutlet weak var switchControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.loadViewFromStoryboard()
    }//eo
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }//eo
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }//eo
    
    //MARK:
    
    /* */
    func loadViewFromStoryboard()
    {
        let sbViewController = self.storyboard?.instantiateViewController(withIdentifier: "smallUIView") as! ViewInUIViewViewController
        sbViewController.view.frame = myUIView.bounds
        
        myUIView.addSubview(sbViewController.view)
        
        addChildViewController(sbViewController)
        
        sbViewController.didMove(toParentViewController: self)

    }//eom
    
    
    func loadViewFromNib()
    {
        let nibController = ViewInNIBViewController()
        nibController.view.frame = myUIView.bounds
        
        myUIView.addSubview(nibController.view)
        
        addChildViewController(nibController)
        
        nibController.didMove(toParentViewController: self)
    
    }//eom

    
    //MARK: Switching Views
    
    @IBAction func viewSelectionChanged(_ sender: AnyObject)
    {
        if sender.selectedSegmentIndex == 0
        {
            print("loading view from Storyboard ")
            self.loadViewFromStoryboard()
        }
        else if sender.selectedSegmentIndex == 1
        {
            print("loading view from NIB")
            self.loadViewFromNib()
        }
        
    }//eo-a
    
    
    
    //MARK: Memory
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}

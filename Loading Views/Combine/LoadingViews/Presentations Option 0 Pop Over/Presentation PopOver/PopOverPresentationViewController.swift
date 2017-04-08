//
//  PopOverPresentationViewController.swift
//  LoadingViews
//
//  Created by Luis Castillo on 4/8/17.
//  Copyright © 2017 devbros. All rights reserved.
//

import Foundation

class PopOverPresentationViewController: UIViewController
{
    //MARK: - Properties
    fileprivate let popOverSegue:String = "showPopOverView"
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Navigation
    @IBAction func showView(_ sender: AnyObject) {
        self.performSegue(withIdentifier: popOverSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == popOverSegue {
            let vc = segue.destination
            let controller = vc.popoverPresentationController
            if controller != nil {
                controller?.delegate = self
            }
        }
    }
}

//MARK: - UIPopoverPresentationControllerDelegate
extension PopOverPresentationViewController:UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

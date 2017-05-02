//
//  TransitionMainViewController.swift
//  LoadingViews
//
//  Created by lu on 5/2/17.
//  Copyright © 2017 devbros. All rights reserved.
//

import UIKit

class TransitionFadeMainViewController: UIViewController {
    
    //MARK: - UI Properties
    @IBOutlet weak var subview:UIView!
    @IBOutlet weak var showOrHideButton: UIButton!
    
    //MARK: - Properties
    let subController = TransitionSubviewViewController()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
       setupSubController()
    }
    
    //MARK: - Action
    @IBAction func showSubviewPressed(sender: UIButton){
        if subview.isHidden {
            presentSubView()
        }
        else {
            dismissSubView()
        }
    }
}

//MARK: - Setup
extension TransitionFadeMainViewController {
    func setupSubController(){
        
        subController.view.frame = subview.bounds
        subview.addSubview(subController.view)
        
        addChildViewController(subController)
        subController.didMove(toParentViewController: self)
        
        subController.delegate = self
        
        subview.isHidden = true
        
        //round corner look
        subController.view.layer.borderWidth = 1
        subController.view.layer.borderColor = UIColor.clear.cgColor
        subController.view.layer.cornerRadius = 10
    }
    
    func dismissSubView(){
        let transition: CATransition = CATransition()
        transition.duration         = 0.4
        transition.timingFunction   = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type         = kCATransitionFade
        transition.subtype      = kCATransitionFromBottom
        subview.window?.layer.add(transition, forKey: nil)
        subview.isHidden = true
    }
    
    func presentSubView(){
        let transition: CATransition = CATransition()
        transition.duration         = 0.4
        transition.timingFunction   = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type         = kCATransitionFade
        transition.subtype      = kCATransitionFromTop
        subview.window?.layer.add(transition, forKey: nil)
        subview.isHidden = false
    }
}

//MARK: - subControllerDelegate
extension TransitionFadeMainViewController:subControllerDelegate {
    func subCancelPressed() {
        dismissSubView()
    }
    
    func subSubmitPressed() {
        presentSubView()
    }
}

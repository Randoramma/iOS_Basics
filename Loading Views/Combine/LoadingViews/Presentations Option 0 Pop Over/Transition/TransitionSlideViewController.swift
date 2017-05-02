//
//  TransitionSlideViewController.swift
//  LoadingViews
//
//  Created by lu on 5/2/17.
//  Copyright © 2017 devbros. All rights reserved.
//

import UIKit

class TransitionSlideViewController: UIViewController {
    
    //MARK: - UI Properties
    @IBOutlet weak var subview:UIView!
    @IBOutlet weak var showOrHideButton: UIButton!
    
    //MARK: - Properties
    let subController = TransitionSubviewViewController()
    fileprivate var subviewOriginalFrame:CGRect = CGRect()
    fileprivate var subviewPresented:Bool = false
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubController()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        hideSubview()
    }
    
    //MARK: - Action
    @IBAction func showSubviewPressed(sender: UIButton){
        if subviewPresented {
            dismissSubView()
        }
        else {
            presentSubView()
        }
    }
}

//MARK: - Setup
extension TransitionSlideViewController {
    func setupSubController(){
        subController.view.frame = subview.bounds
        subview.addSubview(subController.view)
        
        addChildViewController(subController)
        subController.didMove(toParentViewController: self)
        
        subController.delegate = self
        
        //round corner look
        subController.view.layer.borderWidth = 1
        subController.view.layer.borderColor = UIColor.clear.cgColor
        subController.view.layer.cornerRadius = 10
        
        //saving original frame
        subviewOriginalFrame = subview.frame
    }
    
    func hideSubview(){
        let bottomFrame = CGRect(x: 0,
                                 y: self.view.frame.height,
                                 width: self.subview.frame.width,
                                 height: self.subview.frame.height)
        self.subview.frame = bottomFrame
        self.subview.setNeedsLayout()
        self.subview.layoutIfNeeded()
    }
    
    func dismissSubView(){
        print("dismiss")
        
        print("screen height: ", UIScreen.main.bounds.size.height)
        print("view height: ", self.view.frame.height)
        
        
        UIView.animate(withDuration: 0.9) {
            let bottomFrame = CGRect(x: 0,
                                     y: self.view.frame.height,
                                     width: self.subview.frame.width,
                                     height: self.subview.frame.height)
            self.subview.frame = bottomFrame
        }
        subviewPresented = false
        
    }
    
    func presentSubView(){
        print("presenting")
        UIView.animate(withDuration: 0.9) {
            self.subview.frame = self.subviewOriginalFrame
        }
        
        subviewPresented = true
    }
}

//MARK: - subControllerDelegate
extension TransitionSlideViewController:subControllerDelegate {
    func subCancelPressed() {
        dismissSubView()
    }
    
    func subSubmitPressed() {
        dismissSubView()
    }
}


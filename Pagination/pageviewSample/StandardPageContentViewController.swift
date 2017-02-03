//
//  StandardPageContentViewController.swift
//  pageviewSample
//
//  Created by Luis Castillo on 8/14/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit


protocol StandardPageContentNotificationDelegate {
    func pageDismiss_down()
}


class StandardPageContentViewController: UIViewController {

    var pageDelegate:StandardPageContentNotificationDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var pageIndex:Int = 0
    
    var titleText:String = ""
    var imageFile:String = ""
    
    //MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = UIImage(named: imageFile)
        self.titleLabel.text = titleText
        
        
        self.setupSwipeGestures()
    }//eom
    
    //MARK: - Swipe Gestures
    private func setupSwipeGestures()
    {
        imageView.isUserInteractionEnabled = true
        
        //up
        let selector_swipe_up = #selector(StandardPageContentViewController.respondToSwipe(_:))
        let swipeUp = UISwipeGestureRecognizer(target: self, action: selector_swipe_up)
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        
        imageView.addGestureRecognizer(swipeUp)
        
        //down
        let selector_swipe_down = #selector(StandardPageContentViewController.respondToSwipe(_:))
        let swipeDown = UISwipeGestureRecognizer(target: self, action: selector_swipe_down)
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        
        imageView.addGestureRecognizer(swipeDown)
    }//eom
    
    func respondToSwipe(_ gesture: UIGestureRecognizer)
    {
        if let swipeGesture:UISwipeGestureRecognizer = gesture as? UISwipeGestureRecognizer
        {
            switch swipeGesture.direction
            {
            case UISwipeGestureRecognizerDirection.down:
                self.pageDelegate?.pageDismiss_down()
                print("SWIPE DOWN")
                break
            default:
                break
            }
        }
    }//eom
    
    //MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be rpoecreated.
    }//eom
    
    
}//eoc

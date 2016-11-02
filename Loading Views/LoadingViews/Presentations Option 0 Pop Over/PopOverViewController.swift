//
//  PopOverViewController.swift
//  LoadingViews
//
//  Created by Luis Castillo on 12/30/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import UIKit
import QuartzCore


class PopOverViewControllerSwift: UIViewController {

    @IBOutlet weak var viewToDisplay: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    //MARK: View Loading
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.viewToDisplay.layer.cornerRadius = 5
        self.viewToDisplay.layer.shadowOpacity = 0.8
        self.viewToDisplay.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        
        self.setupGesturesToCloseView()
        
    }
    
    //MARK: Show View
    
    func showInView(_ aView: UIView!, animated: Bool)
    {
        aView.addSubview(self.view)
        if animated
        {
            self.showAnimate()
        }
    }
    

    //MARK: Animations
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }
    
    //MARK: Close
    func closeView()
    {
        self.removeAnimate()
    }//eom
    
    //MARK: Gesture Setup
    func setupGesturesToCloseView()
    {
//        //double tap
//        let tap = UITapGestureRecognizer.init(target: self, action: "closeView")
//        self.view .addGestureRecognizer(tap)
        
        //swipes
        let swipe = UISwipeGestureRecognizer.init(target: self,
                                                  action: #selector(PopOverViewControllerSwift.closeView as (PopOverViewControllerSwift) -> () -> ()))
        swipe.direction = UISwipeGestureRecognizerDirection.right
        
        self.view .addGestureRecognizer(swipe)
        
    }//eom
    
    @IBAction func closeView(_ sender: AnyObject)
    {
        self.closeView()
    }//eo-a
    
    
    //MARK: Memory
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

//
//  StandardViewController.swift
//  pageviewSample
//
//  Created by Luis Castillo on 8/14/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class StandardViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
        @IBOutlet weak var okayButton: UIButton!
        @IBOutlet weak var pageControl: UIPageControl!
        @IBOutlet weak var contentView: UIView!
    
        private var pageViewController:UIPageViewController? = nil
        private var _contents:[NSDictionary] = []
        
        //MARK: Views
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //setting content
            let items = [
                            [
                            "title":"Over 200 Tips and Tricks",
                            "image":"page1.png"
                            ],
                            [
                            "title":"Discover Hidden Features",
                            "image":"page2.png"
                            ],
                            [
                            "title":"Bookmark Favorite Tip",
                            "image":"page3.png"
                            ],
                            [
                            "title":"Free Regular Update",
                            "image":"page4.png"
                            ]
                        ]
            self._contents = items
            
            
            //setting page view controller
            self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("pageVC") as? UIPageViewController
            self.pageViewController?.dataSource = self
            self.pageViewController?.delegate = self
            
            if let startingPageController:StandardPageContentViewController = self.viewControllerAtIndex(0)
            {
                self.pageViewController?.setViewControllers([startingPageController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
                
                self.pageViewController!.view.frame = self.contentView.bounds
                
                self .addChildViewController(self.pageViewController!)
                self.contentView .addSubview(self.pageViewController!.view)
                self.pageViewController!.didMoveToParentViewController(self)
                
                //uodating page control init info
                self.pageControl.numberOfPages = self._contents.count
                self.pageControl.currentPage = 0
            }
            else
            {
                print("something wrong happen")
            }
            
        }//eom
    
        //MARK: - Current Page Displayed
        func pageViewController(pageViewController: UIPageViewController, didFinishAnimating
                                    finished: Bool,
                                    previousViewControllers: [UIViewController],
                                    transitionCompleted completed: Bool)
        {
            if let currVC:StandardPageContentViewController = pageViewController.viewControllers?.first as? StandardPageContentViewController
            {
                let currIndex = currVC.pageIndex
                
                self.pageControl.currentPage = currIndex
                
                //last page so lets hide page control & show Okay Button
                if (currIndex+1) == self._contents.count
                {
                    self.pageControl.hidden = true
                    self.okayButton.hidden = false
                }
                else
                {
                    //resetting just incase
                    self.okayButton.hidden = true
                    self.pageControl.hidden = false
                }
            }
        }//eom
    
        //MARK: Dismiss
        @IBAction func dismissView(sender: AnyObject) {
                self.navigationController?.popViewControllerAnimated(true)
        }//eo-a
    
    
        //MARK: - Delegates
        func pageViewController(pageViewController: UIPageViewController,
                                viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
        {
            guard let controller:StandardPageContentViewController = viewController as? StandardPageContentViewController else {
                return nil
            }
            
            var index:NSInteger = controller.pageIndex
            if (index == 0) || (index == NSNotFound)
            {
                return nil
            }
            
            index += -1
            
            return self.viewControllerAtIndex(index)
        }//eom
        
        func pageViewController(pageViewController: UIPageViewController,
                                viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
        {
            guard let controller:StandardPageContentViewController = viewController as? StandardPageContentViewController else {
                return nil
            }
            
            var index:NSInteger = controller.pageIndex
            if (index == NSNotFound)
            {
                return nil
            }
            
            index += 1
            if index == self._contents.count {
                return nil
            }
            
            return self.viewControllerAtIndex(index)
        }//eom
        
        //MARK: Helpers
        
        /**
         Checks if the current index its valid.
         returns a new pageContentViewController with its data
         */
        func viewControllerAtIndex(index:NSInteger)->StandardPageContentViewController?
        {
            //invalid index
            if ( (self._contents.count == 0) || (index >= self._contents.count) ) {
                return nil
            }
            
            //creating new controller
            guard let controller:StandardPageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("StandardPageContentVC") as? StandardPageContentViewController else
            {
                return nil
            }
            
            //updating vc data
            let currItem:NSDictionary = self._contents[index]
            
            if
            let imageName:String = currItem.valueForKey("image") as? String,
            let titleName:String = currItem.valueForKey("title") as? String
            {
                controller.imageFile = imageName
                controller.titleText = titleName
                controller.pageIndex = index
            }
            
            return controller
        }//eom
    
        //MARK: - Memory
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }//eom

}//eoc

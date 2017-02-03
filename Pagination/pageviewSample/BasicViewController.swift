//
//  ViewController.swift
//  pageviewSample
//
//  Created by Luis Castillo on 7/24/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController,
                            UIPageViewControllerDataSource,
                            BasicPageContentNotificationDelegate {

    fileprivate var pageViewController:UIPageViewController? = nil
    fileprivate var _pageTitles:[String] = []
    fileprivate var _pageImages:[String] = []
    
    
    var onboardingDelegate:OnboardingDelegate? = nil
    
    @IBOutlet weak var gotItButton: UIButton!
    @IBOutlet weak var startAgainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting content
        self._pageTitles = ["Over 200 Tips and Tricks",
                            "Discover Hidden Features",
                            "Bookmark Favorite Tip",
                            "Free Regular Update",
                            " "]
        self._pageImages = ["page1.png",
                            "page2.png",
                            "page3.png",
                            "page4.png",
                            "page5.png"]
        
        //setting page view controller
        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "pageVC") as? UIPageViewController
        
        self.pageViewController?.dataSource = self
        
        if let startingPageController:BasicPageContentViewController = self.viewControllerAtIndex(0)
        {
            self.pageViewController?.setViewControllers([startingPageController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
            
            self.pageViewController!.view.frame = CGRect(x: 0,y: 0,width: self.view.frame.size.width, height: self.view.frame.size.height-60)
            
            self .addChildViewController(self.pageViewController!)
            self.view .addSubview(self.pageViewController!.view)
            self.pageViewController!.didMove(toParentViewController: self)
        }
        else
        {
            print("something wrong happen")
            self.onboardingDelegate?.dismiss()
        }
        
    }//eom
    

    @IBAction func startPageView(_ sender: UIButton) {
        if let startingPageController:BasicPageContentViewController = self.viewControllerAtIndex(0)
        {
            self.pageViewController?.setViewControllers([startingPageController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        }
        else
        {
            print("something wrong happen")
            self.onboardingDelegate?.dismiss()
        }
    }//eo-a
    
    @IBAction func gotIt(_ sender: AnyObject) {
        self.onboardingDelegate?.dismiss()
    }
    
    //MARK: - Page Content Delegate
    func pageDismiss_down() {
        print("dismiss - down swipe ")
        self.onboardingDelegate?.dismiss()
    }//eom
    
    //MARK: - Delegates
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        guard let controller:BasicPageContentViewController = viewController as? BasicPageContentViewController else {
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
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let controller:BasicPageContentViewController = viewController as? BasicPageContentViewController else {
            return nil
        }
        
        var index:NSInteger = controller.pageIndex
        if (index == NSNotFound)
        {
            return nil
        }
        
        index += 1
        
        if (index) == self._pageTitles.count {
            print("dismiss view by last page")
            self.onboardingDelegate?.dismiss()
        }
        else if index == self._pageTitles.count {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    }//eom
    
    //MARK: Helper
    
    /**
        Checks if the current index its valid.
        returns a new pageContentViewController with its data
     */
    func viewControllerAtIndex(_ index:NSInteger)->BasicPageContentViewController?
    {
        //invalid index
        if ( (self._pageTitles.count == 0) || (index >= self._pageTitles.count) ) {
            return nil
        }
        
        //creating new controller & updating its data
        guard let controller:BasicPageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "BasicPageContentVC") as? BasicPageContentViewController else
        {
            return nil
        }
        
        //page content delegate
        controller.pageDelegate = self
        
        controller.imageFile = self._pageImages[index]
        controller.titleText = self._pageTitles[index]
        controller.pageIndex = index
        
        return controller
    }//eom
    
    //MARK: shows the page indicator for pagecontentviewcontroller
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        
        return self._pageTitles.count
    }//eom
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        return 0
    }//eom
    
    //MARK: -Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


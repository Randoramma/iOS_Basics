//
//  ViewController.swift
//  pageviewSample
//
//  Created by Luis Castillo on 7/24/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPageViewControllerDataSource {

    private var pageViewController:UIPageViewController? = nil
    private var _pageTitles:[String] = []
    private var _pageImages:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting content
        self._pageTitles = ["Over 200 Tips and Tricks", "Discover Hidden Features", "Bookmark Favorite Tip", "Free Regular Update"]
        self._pageImages = ["page1.png", "page2.png", "page3.png", "page4.png"]
        
        //setting page view controller
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("pageVC") as? UIPageViewController
        
        self.pageViewController?.dataSource = self
        
        if let startingPageController:PageContentViewController = self.viewControllerAtIndex(0)
        {
            self.pageViewController?.setViewControllers([startingPageController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
            
            self.pageViewController!.view.frame = CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height-60)
            
            self .addChildViewController(self.pageViewController!)
            self.view .addSubview(self.pageViewController!.view)
            self.pageViewController!.didMoveToParentViewController(self)
        }
        else
        {
            print("something wrong happen")
        }
        
    }//eom

    @IBAction func startPageView(sender: UIButton) {
        if let startingPageController:PageContentViewController = self.viewControllerAtIndex(0)
        {
            self.pageViewController?.setViewControllers([startingPageController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        else
        {
            print("something wrong happen")
        }

    }//eo-a
    
    //MARK: - Delegates
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        guard let controller:PageContentViewController = viewController as? PageContentViewController else {
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
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        guard let controller:PageContentViewController = viewController as? PageContentViewController else {
            return nil
        }
        
        var index:NSInteger = controller.pageIndex
        if (index == NSNotFound)
        {
            return nil
        }
        
        index += 1
        if index == self._pageTitles.count {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    }//eom
    
    //MARK: Helper
    
    /**
        Checks if the current index its valid.
        returns a new pageContentViewController with its data
     */
    func viewControllerAtIndex(index:NSInteger)->PageContentViewController?
    {
        //invalid index
        if ( (self._pageTitles.count == 0) || (index >= self._pageTitles.count) ) {
            return nil
        }
        
        //creating new controller & updating its data
        guard let controller:PageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentVC") as? PageContentViewController else
        {
            return nil
        }
        
        controller.imageFile = self._pageImages[index]
        controller.titleText = self._pageTitles[index]
        controller.pageIndex = index
        
        return controller
    }//eom
    
    //MARK: shows the page indicator for pagecontentviewcontroller
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self._pageTitles.count
    }//eom
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }//eom
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


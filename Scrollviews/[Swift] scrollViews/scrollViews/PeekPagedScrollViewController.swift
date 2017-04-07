//
//  PeekPagedScrollViewController.swift
//  scrollViews
//
//  Created by Luis Andres Castillo Hernandez on 7/17/15.
//  Copyright (c) 2015 ninestack. All rights reserved.
//

import UIKit

class PeekPagedScrollViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    
    var pageImages: [UIImage] = []
    var pageViews: [UIImageView?] = []

    /*  */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the image you want to scroll & zoom and add it to the scroll view
        pageImages = [UIImage(named: "photo1.png")!,
            UIImage(named: "photo2.png")!,
            UIImage(named: "photo3.png")!,
            UIImage(named: "photo4.png")!,
            UIImage(named: "photo5.png")!]
        
        let pageCount = pageImages.count
        
        // Set up the page control
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount
        
        // Set up the array to hold the views for each page
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        // Set up the content size of the scroll view
        let pagesScrollViewSize = scrollView.frame.size
        let scrollWidth:CGFloat = pagesScrollViewSize.width * CGFloat(pageImages.count)
        let scrollHeight:CGFloat = pagesScrollViewSize.height
        scrollView.contentSize = CGSize(width: scrollWidth, height: scrollHeight)
        
        
        print("scrollview info:")
        print(" current frame size: \(scrollView.frame)")
        print(" current description: \(scrollView.debugDescription)")
        print("")
        
        let debugInfo:String = (scrollView.gestureRecognizers?.debugDescription != nil) ? (scrollView.gestureRecognizers!.debugDescription) : "no info"
        
        print(" current description: \(debugInfo)")
        
        // Load the initial set of pages that are on screen
        loadVisiblePages()
        
        
        print("_________________________________________")
    }


    
    /*  */
    func loadPage(page: Int) {
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            
             print("     page # \(page) its outside the range allowed")
            
            
            return
        }
        
        // Load an individual page, first checking if you've already loaded it
        if pageViews[page] != nil {
            // Do nothing. The view is already loaded.
            
            print("     page # \(page) was already loaded, no action taken")
        } else {
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            
            
            //The below line makes it different the other type of types.
            // sets the frame of the image view to be slightly inset horizontally, 
                //such that the pages don’t touch.
            frame = frame.insetBy(dx: 90.0, dy: 0.0)
            
            
            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .scaleAspectFit
            newPageView.frame = frame
            scrollView.addSubview(newPageView)
            
            
            
            print("     created new UIImageview of page#\(page)")
            
            pageViews[page] = newPageView
        }
    }
    
    /*  */
    func purgePage(page: Int) {
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        // Remove a page from the scroll view and reset the container array
        if let pageView = pageViews[page] {
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
    }
    
    /*  */
    func loadVisiblePages() {
        // First, determine which page is currently visible
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        // Update the page control
        pageControl.currentPage = page
        
        // Work out which pages you want to load
        let firstPage = page - 1
        let lastPage = page + 1
        
        // Purge anything before the first page
//        for var index = 0; index < firstPage; ++index
        for index in 0..<firstPage
        {
            purgePage(page: index)
        }
        
        // Load pages in our range
        for index in firstPage...lastPage
        {
            loadPage(page: index)
        }
        
        // Purge anything after the last page
//        for var index = lastPage+1; index < pageImages.count; ++index
        for index in lastPage+1..<pageImages.count
        {
            purgePage(page: index)
        }
    }
    
    /*  */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Load the pages that are now on screen
        loadVisiblePages()
    }


}

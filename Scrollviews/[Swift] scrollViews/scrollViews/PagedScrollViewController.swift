//
//  PagedScrollViewController.swift
//  scrollViews
//
//  Created by Luis Andres Castillo Hernandez on 7/17/15.
//  Copyright (c) 2015 ninestack. All rights reserved.
//

import UIKit

class PagedScrollViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    
    var pageImages: [UIImage] = []      // hold all the images to display – 1 per page
    var pageViews: [UIImageView?] = []  //will hold instances of UIImageView to display each image on its respective page
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up the page images.
        pageImages = [UIImage(named: "photo1.png")!,
            UIImage(named: "photo2.png")!,
            UIImage(named: "photo3.png")!,
            UIImage(named: "photo4.png")!,
            UIImage(named: "photo5.png")!]
        
        let pageCount = pageImages.count
//        println("total \(pageCount) pages")
        
        // set the page control to the first page and tell it how many pages there are
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount
        
        // set up the array that holds the UIImageView instances
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        print( "page view count: \(pageViews.count)" )
        
        // calculate the width to be the number of pages multiplied by the width of the scroll view. 
        // The height of the content is the same as the height of the scroll view.
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageImages.count),
            height: pagesScrollViewSize.height)
    
        print("scrollview info:")
        print(" current frame size: \(scrollView.frame)")
        print(" current description: \(scrollView.debugDescription)")
        print("")
        print(" current description: \(scrollView.gestureRecognizers?.debugDescription)")
        
        
        // 5
        loadVisiblePages()
    
        print("_________________________________________")
    }
    
    
    /* loads a page if applicable */
    func loadPage(page: Int) {
        if page < 0 || page >= pageImages.count {
            // If it's outside the range of what you have to display, then do nothing
            print("     page # \(page) its outside the range allowed")
            
            return
        }
        
        // using optional binding to check if you’ve already loaded the view
        if let pageView = pageViews[page] {
            // Do nothing. The view is already loaded.
            print("     page # \(page) was already loaded, no action taken")
        } else {
            // need to create a page. So first, work out the frame for this page
            //It’s calculated as being the same size as the scroll view, positioned at zero y offset, 
            // and then offset by the width of a page multiplied by the page number in the x (horizontal) direction
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            
            // creates a new UIImageView, sets it up and adds it to the scroll view.
            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .ScaleAspectFit
            newPageView.frame = frame
            scrollView.addSubview(newPageView)
            
            print("     created new UIImageview of page#\(page)")
            
            // you replace the nil in the pageViews array with the view you’ve just created, 
            //so that if this page was asked to load again, you would now not go into the if statement and instead do nothing, 
            //since the view for the page has already been created.
            pageViews[page] = newPageView
        }
    }
    
    /* purges a page that was previously created via loadPage(). */
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
    
    /* find the page the scroll view is currently on, update the page control and then load or purge the relevant pages*/
    func loadVisiblePages() {
        // First, determine which page is currently visible
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        // Update the page control
        pageControl.currentPage = page
        
        
        // Work out which pages you want to load
        let firstPage = page - 1
        let lastPage = page + 1
        
        
        print("")
        print("COUNT:")
        print("   Prev page (first page)# \(firstPage)")
        print("   current page#\(page)")
        print("   Next Page(last page)# \(lastPage)")
        
        print("PURGING: (goes front 0 to prevPage)")
        // Purge anything before the first page
        for var index = 0; index < firstPage; ++index {
            print("   purging page# \(index)")
            purgePage(index)
        }
        
        print("LOADING: (goes front prevPage to Next Page)")
        // Load pages in our range
        for index in firstPage...lastPage {
            print("   loading page# \(index)")
            loadPage(index)
        }
        
        // Purge anything after the last page
        for var index = lastPage+1; index < pageImages.count; ++index {
            print("purging (after last page\(lastPage)) page# \(index)")
            purgePage(index)
        }
        print("- - - - - - - - - - - - - - - - - -")
    }
    
    /*UIScrollView delegate - ensure that as the scroll view is scrolled, the relevant pages are always loaded (and that unnecessary pages are purged) */
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Load the pages that are now on screen
        loadVisiblePages()
    }
}//eoc

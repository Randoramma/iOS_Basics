//
//  InfiteHorizontalViewController.swift
//  scrollViews
//
//  Created by Luis Andres Castillo Hernandez on 7/19/15.
//  Copyright (c) 2015 ninestack. All rights reserved.
//

import UIKit

class InfiteHorizontalViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
  
    let numPages: Int = 3
    var documentTitle = [String]()
    
    var prevIndex: Int = 0, currIndex: Int = 0, nextIndex: Int = 0
    var pages = [UILabel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // create our array of documents
        for (var i = 0; i < 10; i++) {
            documentTitle.insert(String(format: "Page %i", i), atIndex: i)
        }
        
        initSubviews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**/
    func initSubviews() {
//        var fm: CGRect = UIScreen.mainScreen().bounds
        
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * CGFloat(numPages), scrollView.frame.size.height)
        
//        println("[horizontal] frame size: \(scrollView.frame)")
        
        scrollView.backgroundColor = UIColor.greenColor()

        //moves the scrollview to the middle page
        scrollView.scrollRectToVisible(CGRectMake(scrollView.frame.size.width,0, scrollView.frame.size.width, scrollView.frame.size.height), animated: false)
        
        
//        println("[horizontal] scrollRectToVisible updated to   ( \(scrollView.frame.size.width), 0, \(scrollView.frame.size.width), \(scrollView.frame.size.height)) ")
        
        /*creates 3 UIlabels and adds them to the UIScollview */
        for i in 0...(numPages-1) {
            //            var tempLabel = UILabel(frame:  CGRectMake(0, scrollView.frame.size.width * CGFloat(i), scrollView.frame.size.width, scrollView.frame.size.height))
            let tempLabel = UILabel(frame:  CGRectMake(scrollView.frame.size.width * CGFloat(i), 0,scrollView.frame.size.width, scrollView.frame.size.height))
            tempLabel.textAlignment = NSTextAlignment.Center
            
            
            print("[horizontal] adding label to \(tempLabel.description)")
            
            pages.insert(tempLabel, atIndex: i)
            scrollView.addSubview(pages[i]);
        }
        
        /*updating array of UIlabels with page number*/
        loadPageWithId(9, onPage: 0)
        loadPageWithId(0, onPage: 1)    // starting page
        loadPageWithId(1, onPage: 2)
    }
    
    /*updates 1 of the 3 UIlabels in the array of UIlabels, this is necessary to show the correct information UIlabel while scrolling*/
    func loadPageWithId(index: Int, onPage page: Int) {
        switch(page) {
        case 0:
            pages[0].text = documentTitle[index]
//            println("updated pages[0] with value \(documentTitle[index])")
            break
        case 1:
            pages[1].text = documentTitle[index]
//            println("updated pages[1] with value \(documentTitle[index])")
            break
        case 2:
            pages[2].text = documentTitle[index]
//            println("updated pages[2] with value \(documentTitle[index])")
            break
        default:
            break
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //print("scrolling...")
    }
    
    /*updates the values of the UIlabels when the uiscrolling detects is moving is about to be stopped*/
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        // moving forward
        if(scrollView.contentOffset.x >= scrollView.frame.size.width) {
            
//            println("***moving forward***")

            scrollView.backgroundColor = UIColor.lightGrayColor()
            
            // load current doc data on first page
            loadPageWithId(currIndex, onPage: 0)
            
            // add one to current index or reset to 0 if reached end
            currIndex = (currIndex >= documentTitle.count - 1) ? 0 : currIndex + 1
            loadPageWithId(currIndex, onPage: 1)
            
            // last page contains either next time in array or first if we reached the end
            nextIndex = (currIndex >= documentTitle.count - 1) ? 0 : currIndex + 1
            loadPageWithId(nextIndex, onPage: 2)
        }
        
        
        if(scrollView.contentOffset.x < scrollView.frame.size.width) {
            
//            println("***moving backward***")

            scrollView.backgroundColor = UIColor.greenColor()

            // load current doc data on last page
            loadPageWithId(currIndex, onPage: 2)
            
            // subtract one from current index or go to the end if we have reached the beginning
            currIndex = (currIndex == 0) ? documentTitle.count - 1 : currIndex - 1
            loadPageWithId(currIndex, onPage: 1)
            
            // first page contains either the prev item in array or the last item if we have reached the beginning
            prevIndex = (currIndex == 0) ? documentTitle.count - 1 : currIndex - 1
            loadPageWithId(prevIndex, onPage: 0)
        }
        
        // reset offset to the middle page
    scrollView.scrollRectToVisible(CGRectMake(scrollView.frame.size.width,0, scrollView.frame.size.width, scrollView.frame.size.height), animated: false)
        
//        println("[horizontal] offset: \(scrollView.contentOffset)")
    }
    
}

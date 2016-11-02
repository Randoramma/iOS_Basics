//
//  InfiniteVerticalViewController.swift
//  scrollViews
//
//  Created by Luis Andres Castillo Hernandez on 7/19/15.
//  Copyright (c) 2015 ninestack. All rights reserved.
//

import UIKit

class InfiniteVerticalViewController: UIViewController, UIScrollViewDelegate {

    let numPages: Int = 3
    var mainScrollView: UIScrollView?
    var documentTitle = [String]()
    
    var prevIndex: Int = 0, currIndex: Int = 0, nextIndex: Int = 0
    var pages = [UILabel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // create our array of documents
        for i in 0 ..< 10
        {
            documentTitle.insert(String(format: "Page %i", i), at: i)
        }
        
        initSubviews()
        
        view.addSubview(mainScrollView!);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initSubviews() {
        let fm: CGRect = UIScreen.main.bounds
        
        self.mainScrollView = UIScrollView(frame:CGRect(x: 0, y: 0, width: fm.size.width, height: fm.size.height))
        
//        println("scrollview first setup with \(mainScrollView?.frame)")
        
        self.mainScrollView!.contentSize = CGSize(width: self.mainScrollView!.frame.size.width, height: self.mainScrollView!.frame.size.height * CGFloat(numPages))
        
//        println("scrollview updated to (after contentsize)   \(mainScrollView?.contentOffset.x) \(mainScrollView?.contentOffset.y)")
        
        self.mainScrollView!.backgroundColor = UIColor.green
        self.mainScrollView!.isPagingEnabled = true
        self.mainScrollView!.bounces = false
        self.mainScrollView!.showsHorizontalScrollIndicator = false;
        
        
        //moves the scrollview to the middle page
        self.mainScrollView!.scrollRectToVisible(CGRect(x: 0, y: mainScrollView!.frame.size.height, width: mainScrollView!.frame.size.width, height: mainScrollView!.frame.size.height), animated: false)
        
        
        
//        println("scrollRectToVisible updated to   0, \(mainScrollView!.frame.size.height), \(mainScrollView!.frame.size.width), \(mainScrollView!.frame.size.height) ")
        
        self.mainScrollView!.delegate = self
        
        
        /*creates 3 UIlabels and adds them to the UIScollview */
        for i in 0...(numPages-1) {
        
            let tempLabel = UILabel(frame:  CGRect(x: 0, y: self.mainScrollView!.frame.size.height * CGFloat(i), width: fm.size.width, height: fm.size.height))
            tempLabel.textAlignment = NSTextAlignment.center
            
            
            print("adding label to \(tempLabel.description)")
            
            pages.insert(tempLabel, at: i)
            self.mainScrollView!.addSubview(pages[i]);
        }
        
        /*updating array of UIlabels with page number*/
        loadPageWithId(9, onPage: 0)
        loadPageWithId(0, onPage: 1) // starting page
        loadPageWithId(1, onPage: 2)
    }
    
    /*updates 1 of the 3 UIlabels in the array of UIlabels, this is necessary to show the correct information UIlabel while scrolling*/
    func loadPageWithId(_ index: Int, onPage page: Int) {
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //println("scrolling...")
    }
    
    /*updates the values of the UIlabels when the uiscrolling detects is moving is about to be stopped*/
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // moving forward
        if(scrollView.contentOffset.y > mainScrollView!.frame.size.height) {
            
//            println("***moving forward***")
            // load current doc data on first page
            loadPageWithId(currIndex, onPage: 0)
            
            // add one to current index or reset to 0 if reached end
            currIndex = (currIndex >= documentTitle.count - 1) ? 0 : currIndex + 1
            loadPageWithId(currIndex, onPage: 1)
            
            // last page contains either next time in array or first if we reached the end
            nextIndex = (currIndex >= documentTitle.count - 1) ? 0 : currIndex + 1
            loadPageWithId(nextIndex, onPage: 2)
        }
        
        // moving backward
        if(scrollView.contentOffset.y < mainScrollView!.frame.size.height) {
            
//            println("***moving backward***")
            
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
        self.mainScrollView!.scrollRectToVisible(CGRect(x: 0, y: mainScrollView!.frame.size.height, width: mainScrollView!.frame.size.width, height: mainScrollView!.frame.size.height), animated: false)

        
//            println("offset: \(scrollView.contentOffset)")
    }
    
}

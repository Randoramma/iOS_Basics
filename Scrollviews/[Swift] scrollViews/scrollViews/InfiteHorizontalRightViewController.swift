//
//  InfiteHorizontalRightViewController.swift
//  scrollViews
//
//  Created by Luis Andres Castillo Hernandez on 7/20/15.
//  Copyright (c) 2015 ninestack. All rights reserved.
//

import UIKit

class InfiteHorizontalRightViewController: UIViewController , UIScrollViewDelegate {
    
    
    @IBOutlet var scrollView: UIScrollView!
    
    let numPages: Int = 3
    var documentTitle = [String]()
    
    var prevIndex: Int = -1             //previous index
    var currIndex: Int = 0              //current index
    var nextIndex: Int = 1              //next index
    var backlimit: Int = 0              //num of left scrolling accumulated
    
    var pages = [UILabel]()
    
    var currentNum = 9
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // create our array of documents
        for i in 0 ..< 10
        {
            documentTitle.insert(String(format: "Page %i", i), at: i)
        }
        
        self.initSubviews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**/
    func initSubviews() {
        //        var fm: CGRect = UIScreen.mainScreen().bounds
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(numPages), height: scrollView.frame.size.height)
        
        //        println("[horizontal] frame size: \(scrollView.frame)")
        
        //moves the scrollview to the middle page
//        scrollView.scrollRectToVisible(CGRectMake(scrollView.frame.size.width,0, scrollView.frame.size.width, scrollView.frame.size.height), animated: false)
        
        //        println("[horizontal] scrollRectToVisible updated to   ( \(scrollView.frame.size.width), 0, \(scrollView.frame.size.width), \(scrollView.frame.size.height)) ")
        
        /*creates 3 UIlabels and adds them to the UIScollview */
        for i in 0...(numPages-1) {
            let tempLabel = UILabel(frame:  CGRect(x: scrollView.frame.size.width * CGFloat(i), y: 0,width: scrollView.frame.size.width, height: scrollView.frame.size.height))
            tempLabel.textAlignment = NSTextAlignment.center
            
//            println("[horizontal] adding label to \(tempLabel.description)")
            
            pages.insert(tempLabel, at: i)
            scrollView.addSubview(pages[i]);
        }
        
        /*updating array of UIlabels with page number*/
        loadPageWithId(0, onPage: 0)    // starting page
        loadPageWithId(1, onPage: 1)
        loadPageWithId(2, onPage: 2)
        
        
        print("initial values: prev #\(prevIndex) curr#\(currIndex) next#\(nextIndex)")
        print("backlimit:\(backlimit)    currentNum:\(currentNum)")
        print("[horizontal] offset: \(scrollView.contentOffset)")
        print("[horizontal] frame: \(scrollView.frame)")
        print("")
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
    
    /**/
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //println("scrolling...")
    }
    
    /*updates the values of the UIlabels when the uiscrolling detects is moving is about to be stopped*/
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let movingForward = scrollView.contentOffset.x > scrollView.frame.size.width
        let movingBackward = scrollView.contentOffset.x < scrollView.frame.size.width
        let firstMove = scrollView.contentOffset.x == scrollView.frame.size.width
        
//        println("moving foward is \(movingForward) when offset.x is \(scrollView.contentOffset.x) > frame.size.width is \(scrollView.frame.size.width)")
//        println("moving backward is \(movingBackward) when offset.x is \(scrollView.contentOffset.x) < frame.size.width is \(scrollView.frame.size.width)")
//        println("first move is \(firstMove) when offset.x is \(scrollView.contentOffset.x) == frame.size.width is \(scrollView.frame.size.width)")
        
        // moving forward
        if(movingForward) {
            print("***moving forward ***")

            backlimit += 1                                         //updating num of accum left scrolls
            
            //there is atleast 5 pages on the left
            if(backlimit > 5){
                currentNum += 1                                    //updated page # value - Tempopary Var!!
                documentTitle.remove(at: 0)                  //remove first index
                documentTitle.append("Page \(currentNum)")     //add new index
                backlimit -= 1                                     //reduce backlimit
            
                //updating pages
                loadPageWithId(prevIndex, onPage: 0)                //load current doc data on first page
                loadPageWithId(currIndex, onPage: 1)                //load next doc data on second page
                loadPageWithId(nextIndex, onPage: 2)
            }
            else{
                //there is less than 5 pages on the left, NOT adding indexes yet
                
                prevIndex += 1
                loadPageWithId(prevIndex, onPage: 0)                //load current doc data on first page
                
                currIndex += 1
                loadPageWithId(currIndex, onPage: 1)                //load next doc data on second page
                
                nextIndex += 1
                loadPageWithId(nextIndex, onPage: 2)
            }
        }
        else if(movingBackward) {
            
            print("***moving backward ***")
     
           
            
            //updating UIlabels only if the backlimit has NOT been reached
            if(backlimit > 1){
                
                //updating page of indexes
                nextIndex -= 1
                loadPageWithId( nextIndex, onPage: 2)
                
                currIndex -= 1
                loadPageWithId( currIndex, onPage: 1)
                
                prevIndex -= 1
                loadPageWithId( prevIndex, onPage: 0)
                
                 backlimit -= 1             //updating backlimit
            }
            else
            {
                backlimit = 0
            }
        }
        else if(firstMove){

            backlimit += 1                                     //updating num of accum left scrolls
            
            //updating index values
            prevIndex = currIndex
            currIndex += 1
            
            nextIndex += 1
            loadPageWithId(nextIndex, onPage: 2)
        }
        
        // reset offset to the middle page ONLY if backlimit has NOT been reached
        if(backlimit > 0){
            scrollView.scrollRectToVisible(CGRect(x: scrollView.frame.size.width,y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height), animated: false)
        }
        
        print("[horizontal] offset: \(scrollView.contentOffset) frame: \(scrollView.frame)")
        print("after updating values: prev #\(prevIndex) curr#\(currIndex) next#\(nextIndex)")
        
        print("backlimit:\(backlimit)    currentNum:\(currentNum) ")
        print("\(documentTitle.description)")
        
//        println("actual        values: prev  #\(currentNum-1) curr#\(currentNum) next#\(currentNum+1)")
        print("")
        
    }//eom
    
}

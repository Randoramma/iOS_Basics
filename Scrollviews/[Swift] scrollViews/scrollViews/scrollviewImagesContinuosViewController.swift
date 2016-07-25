//
//  scrollviewImagesContinuosViewController.swift
//  scrollViews
//
//  Created by Luis Andres Castillo Hernandez on 11/22/15.
//  Copyright © 2015 ninestack. All rights reserved.
//

import UIKit

class scrollviewImagesContinuosViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var pageImages: [UIImage]       = []
    var pageViews: [UIImageView?]   = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setup()
    }
    
    
    
    func setup()
    {
        // set up the page images.
        pageImages = [  UIImage(named: "photo1.png")!,
                        UIImage(named: "photo2.png")!,
                        UIImage(named: "photo3.png")!,
                        UIImage(named: "photo4.png")!,
                        UIImage(named: "photo5.png")!]
        
        let pageCount = pageImages.count
        //        println("total \(pageCount) pages")
        
        
        // set up the array that holds the UIImageView instances
        for _ in 0..<pageCount {
            pageViews.append(nil)
        }
        
        
        // Set up the content size of the scroll view
        let pagesScrollViewSize = scrollView.frame.size
        
        let magicNumber:CGFloat = 150.0
        scrollView.contentSize = CGSizeMake(magicNumber * CGFloat(pageImages.count), pagesScrollViewSize.height)
        
        let totalImages = pageImages.count
        
        for(var iter = 0 ; iter < totalImages; iter++)
        {
            self.loadPage(iter)
        }
    }//eom
    
    
    /* loads a page if applicable */
    func loadPage(page: Int) {

            let newPageView         = UIImageView(image: pageImages[page])
            newPageView.contentMode = .ScaleAspectFit
        
            var frame = scrollView.bounds
        
            let magicNumber:CGFloat = 130.0
            frame.origin.x          = CGFloat(page) * magicNumber
            frame.origin.y          = 0.0
        
            newPageView.frame = frame
            scrollView.addSubview(newPageView)
            pageViews[page] = newPageView
    }//eom

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

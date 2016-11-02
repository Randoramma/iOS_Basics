//
//  CustomScrollViewController.swift
//  scrollViews
//
//  Created by Luis Andres Castillo Hernandez on 7/17/15.
//  Copyright (c) 2015 ninestack. All rights reserved.
//

import UIKit

class CustomScrollViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    
    var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the container view to hold your custom view hierarchy
        let containerSize = CGSize(width: 640.0, height: 640.0)
        containerView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size:containerSize))
        scrollView.addSubview(containerView)
        
        // Set up your custom view hierarchy
        let redView = UIView(frame: CGRect(x: 0, y: 0, width: 640, height: 80))
        redView.backgroundColor = UIColor.red;
        containerView.addSubview(redView)
        
        let blueView = UIView(frame: CGRect(x: 0, y: 560, width: 640, height: 80))
        blueView.backgroundColor = UIColor.blue;
        containerView.addSubview(blueView)
        
        let greenView = UIView(frame: CGRect(x: 160, y: 160, width: 320, height: 320))
        greenView.backgroundColor = UIColor.green;
        containerView.addSubview(greenView)
        
        let imageView = UIImageView(image: UIImage(named: "slow.png"))
        imageView.center = CGPoint(x: 320, y: 320);
        containerView.addSubview(imageView)
        
        // Tell the scroll view the size of the contents
        scrollView.contentSize = containerSize;
        
        // Set up the minimum & maximum zoom scales
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight)
        
        
        //set the zoomScale to 1 instead of minScale so that the content view is at normal size, instead of it fitting the screen.
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = 1.0
        
        centerScrollViewContents()
    }//eom
    
    func centerScrollViewContents() {
        let boundsSize = scrollView.bounds.size
        var contentsFrame = containerView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        containerView.frame = contentsFrame
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return containerView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerScrollViewContents()
    }
    
}//eoc

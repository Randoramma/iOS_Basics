//
//  ScrollViewContainer.swift
//  scrollViews
//
//  Created by Luis Andres Castillo Hernandez on 7/17/15.
//  Copyright (c) 2015 ninestack. All rights reserved.
//


/*
 wrapping the scroll view in a container view whose job it is to intercept touches and hand them off to the scroll view.
*/

import UIKit

class ScrollViewContainer: UIView {
    @IBOutlet var scrollView: UIScrollView!
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent!) -> UIView? {
        let view = super.hitTest(point, withEvent: event)
        if let theView = view {
            if theView == self {
                return scrollView
            }
        }
        
        return view
    }
}

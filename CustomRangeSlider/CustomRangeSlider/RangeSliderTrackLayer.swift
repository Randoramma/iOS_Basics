//
//  RangeSliderTrackLayer.swift
//  CustomRangeSlider
//
//  Created by lu on 5/1/17.
//  Copyright © 2017 lu. All rights reserved.
//

import UIKit
import QuartzCore

class RangeSliderTrackLayer: CALayer {
    
    //MARK: - Properties
    weak var rangeSlider: RangeSlider?
    
    //MARK: - Init
    override func draw(in ctx: CGContext) {
        if let slider = rangeSlider {
            //creating path
            let cornerRadius    = bounds.height * slider.curvaceousness / 2.0
            let path = UIBezierPath(roundedRect: bounds,
                                    cornerRadius: cornerRadius)
            ctx.addPath(path.cgPath)
            
            // filling track
            ctx.setFillColor(slider.trackTintColor.cgColor)
            ctx.addPath(path.cgPath)
            (ctx).fillPath()
            
            // filling highlighted range
            ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
            let leftValuePosition   = CGFloat(slider.positionForValue(slider.leftValue))
            let rightValuePosition  = CGFloat(slider.positionForValue(slider.rightValue))
            let rect = CGRect(x: leftValuePosition,
                              y: 0.0,
                              width: rightValuePosition - leftValuePosition,
                              height: bounds.height)
            ctx.fill(rect)
        }
    }
}

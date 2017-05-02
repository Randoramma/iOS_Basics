//
//  RangeSliderLayer.swift
//  CustomRangeSlider
//
//  Created by lu on 5/1/17.
//  Copyright © 2017 lu. All rights reserved.
//

import UIKit
import QuartzCore

class RangeSliderLayer: CALayer {
    
    //MARK: - UI Properties
    weak var rangeSlider:RangeSlider?
    
    //MARK: - Properties
    fileprivate var lineWidthSize:CGFloat = 0.5
    internal let lineShadowColor = UIColor.gray
    fileprivate let lineShadowSize = CGSize(width: 0.0, height: 1.0)
    
    //MARK: Properties (setters)
    var highlighted:Bool = false {
        didSet{
            setNeedsDisplay()
        }
    }
    
    //MARK: - Init
    override func draw(in ctx:CGContext){
        if let slider = rangeSlider {
            let frame           = bounds.insetBy(dx: 2.0, dy: 2.0)
            let cornerRadius    = frame.height * slider.curvaceousness / 2.0
            let path            = UIBezierPath(roundedRect: frame,
                                               cornerRadius: cornerRadius)
            
            // filling (shadow)
            ctx.setShadow(offset: lineShadowSize,
                          blur: 1.0,
                          color: lineShadowColor.cgColor)
            ctx.setFillColor(slider.handleTintColor.cgColor)
            ctx.addPath(path.cgPath)
            (ctx).fillPath()
            
            // outline
            ctx.setStrokeColor(lineShadowColor.cgColor)
            ctx.setLineWidth(lineWidthSize)
            ctx.addPath(path.cgPath)
            ctx.strokePath()
            
            if highlighted {
                let highlightedColor = UIColor(white: 0.0, alpha: 0.1).cgColor
                ctx.setFillColor(highlightedColor)
                ctx.addPath(path.cgPath)
                (ctx).fillPath()
            }
        }
    }
}

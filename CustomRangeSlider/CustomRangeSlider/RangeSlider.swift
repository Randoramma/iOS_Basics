//
//  RangeSlider.swift
//  CustomRangeSlider
//
//  Created by lu on 5/1/17.
//  Copyright © 2017 lu. All rights reserved.
//

import UIKit
import QuartzCore

protocol RangeSliderDelegate:class {
    func leftValueChanged(slider:RangeSlider, value:Double, point:CGPoint)
    func rightValueChanged(slider:RangeSlider, value:Double, point:CGPoint)
}


class RangeSlider: UIControl {
    //MARK: - Properties
    weak var delegate:RangeSliderDelegate?
    
    fileprivate let trackLayer          = RangeSliderTrackLayer()
    fileprivate let leftLayer           = RangeSliderLayer()
    fileprivate let rightLayer          = RangeSliderLayer()
    fileprivate var previousLocation    = CGPoint()
    
    var handleWidth: CGFloat {
        return CGFloat(bounds.height)
    }
    
    var leftLocation: CGPoint {
        return leftLayer.frame.origin
    }
    
    var rightLocation: CGPoint {
        return rightLayer.frame.origin
    }
    
    //MARK: Properties (Setters)
    var minimumValue: Double = 0.0 {
        didSet {
            updateLayerFrames()
        }
    }
    
    var maximumValue: Double = 1.0 {
        didSet {
            updateLayerFrames()
        }
    }
    
    var leftValue: Double = 0.2 {
        didSet {
            updateLayerFrames()
        }
    }
    
    var rightValue: Double = 0.8 {
        didSet {
            updateLayerFrames()
        }
    }
    
    var trackHeight: CGFloat = 0.0 {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }
    
    var trackTintColor: UIColor = UIColor(white: 0.9, alpha: 1.0) {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }
    
    var trackHighlightTintColor: UIColor = UIColor(red: 0.0,
                                                   green: 0.45,
                                                   blue: 0.94,
                                                   alpha: 1.0) {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }
    
    var handleTintColor: UIColor = UIColor.white {
        didSet {
            leftLayer.setNeedsDisplay()
            rightLayer.setNeedsDisplay()
        }
    }
    
    var curvaceousness: CGFloat = 1.0 {
        didSet {
            trackLayer.setNeedsDisplay()
            leftLayer.setNeedsDisplay()
            rightLayer.setNeedsDisplay()
        }
    }
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        trackLayer.rangeSlider = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)
        
        //left
        leftLayer.rangeSlider = self
        leftLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(leftLayer)
        
        //right
        rightLayer.rangeSlider = self
        rightLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(rightLayer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

//MARK: - Updates
extension RangeSlider{
    func updateLayerFrames() {
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        let trackCalcY      = (self.bounds.height / 3)
        trackLayer.frame    = bounds.insetBy(dx: 0.0, dy: trackCalcY )
        trackLayer.setNeedsDisplay()
        
        //left
        let leftCenter = CGFloat(positionForValue(leftValue))
        let leftXValue =  leftCenter - handleWidth / 2.0
        leftLayer.frame = CGRect(x:leftXValue,
                                       y: 0.0,
                                       width: handleWidth,
                                       height: handleWidth)
        leftLayer.setNeedsDisplay()
        
        
        //right
        let rightCenter = CGFloat(positionForValue(rightValue))
        
        let rightXValue = rightCenter - handleWidth / 2.0
        rightLayer.frame = CGRect(x: rightXValue,
                                       y: 0.0,
                                       width: handleWidth,
                                       height: handleWidth)
        rightLayer.setNeedsDisplay()
        
        CATransaction.commit()
    }
    
    func positionForValue(_ value: Double) -> Double {
        let boundWidthDiff:Double   = Double(bounds.width - handleWidth)
        let minValueDiff:Double     = (value - minimumValue)
        let maxValueDiff:Double     = (maximumValue - minimumValue)
        let halfWidthDouble:Double  = Double(handleWidth / 2.0)
        return boundWidthDiff * minValueDiff / maxValueDiff + halfWidthDouble
    }
}

//MARK: - Touch Handlers
extension RangeSlider{
    override func beginTracking(_ touch: UITouch,
                                with event: UIEvent?) -> Bool {
        //updating location
        previousLocation = touch.location(in: self)
        
        // Hit test the left/right layer
        if leftLayer.frame.contains(previousLocation) {
            leftLayer.highlighted = true
        } else if rightLayer.frame.contains(previousLocation) {
            rightLayer.highlighted = true
        }
        
        return leftLayer.highlighted || rightLayer.highlighted
    }
    
    override func continueTracking(_ touch: UITouch,
                                   with event: UIEvent?) -> Bool {
        // Determine how much was dragged
        let location = touch.location(in: self)
        let deltaLocation   = Double(location.x - previousLocation.x)
        let yDeltaValue     = Double(bounds.width - bounds.height)
        let deltaValue      = (maximumValue - minimumValue) * deltaLocation / yDeltaValue
        
        previousLocation = location
        
        // Update the values
        if leftLayer.highlighted {
            leftValue += deltaValue
            leftValue = boundValue(leftValue,
                                   leftValue: minimumValue,
                                   rightValue: rightValue)
            
            delegate?.leftValueChanged(slider: self,
                                       value: leftValue,
                                       point: location)
        } else if rightLayer.highlighted {
            rightValue += deltaValue
            rightValue = boundValue(rightValue,
                                    leftValue: leftValue,
                                    rightValue: maximumValue)
            
            delegate?.rightValueChanged(slider: self,
                                        value: rightValue,
                                        point: location)
        }
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?,
                              with event: UIEvent?) {
        leftLayer.highlighted = false
        rightLayer.highlighted = false
    }
    
    //MARK: Helper
    func boundValue(_ value: Double,
                    leftValue: Double,
                    rightValue: Double) -> Double {
        return min(max(value, leftValue), rightValue)
    }
}

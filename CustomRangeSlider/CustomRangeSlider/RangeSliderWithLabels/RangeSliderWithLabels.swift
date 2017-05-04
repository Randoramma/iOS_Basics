//
//  RangeSliderWithLabels.swift
//  CustomRangeSlider
//
//  Created by lu on 5/2/17.
//  Copyright © 2017 lu. All rights reserved.
//

import UIKit

protocol RangeSliderWithLabelsDelegate:class {
    func sliderValueChanged(slider:RangeSlider, label:UILabel, value:Double)
}

class RangeSliderWithLabels: UIView {
    
    //MARK: - UI Properties
    @IBOutlet weak var labelTopContainerView: UIView!
    @IBOutlet weak var sliderContainerView: UIView!
    @IBOutlet weak var labelBottomContainerView: UIView!
    
    //MARK: - Properties
    var leftLabel:UILabel! = UILabel(frame: CGRect.zero)
    var rightLabel:UILabel! = UILabel(frame: CGRect.zero)
    var view:UIView!
    var slider:RangeSlider = RangeSlider(frame: CGRect.zero)
    weak var delegate:RangeSliderWithLabelsDelegate?
    
    var labelWidth:CGFloat = 50{
        didSet{
            updateLabelFrame()
        }
    }
    
    var leftLabelTopLocation:Bool = true {
        didSet{
            updateLeftLabelLocation()
        }
    }
    
    var rightLabelTopLocation:Bool = false {
        didSet{
            updateRightLabelLocation()
        }
    }
    
    //MARK: - Init
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        setup()
    }
    
    fileprivate func setup(){
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        
        view.backgroundColor = .clear
        
        setSlider()
        setLabels()
    }
    
    fileprivate func loadViewFromNib() -> UIView{
        let bundle = Bundle(for:type(of: self))
        let nib = UINib(nibName: "RangeSliderWithLabels",
                        bundle: bundle)
        let view = nib.instantiate(withOwner: self,
                                   options: nil)[0] as! UIView
        return view
    }
    
    
}

//MARK: - Range Slider
extension RangeSliderWithLabels{
    fileprivate func setSlider(){
        sliderContainerView.backgroundColor         = .clear
       
        slider.delegate = self
        slider.frame = CGRect(x: 0.0,
                              y: 0,
                              width: view.frame.size.width,
                              height: sliderContainerView.frame.size.height)
        sliderContainerView.addSubview(slider)
    }
    
    fileprivate func setLabels(){
        labelTopContainerView.backgroundColor       = .clear
        labelBottomContainerView.backgroundColor    = .clear
        
        leftLabel.text  = ""
        rightLabel.text = ""
        
        //label frames
        leftLabel.frame = CGRect(x: slider.leftLocation.x,
                                 y: 0.0,
                                 width: labelWidth,
                                 height: labelTopContainerView.frame.size.height)
        
        rightLabel.frame = CGRect(x: slider.rightLocation.x,
                                  y: 0.0,
                                  width: labelWidth,
                                  height: labelTopContainerView.frame.size.height)
        
        updateLeftLabelLocation()
        updateRightLabelLocation()
    }
    
    fileprivate func updateLeftLabelLocation(){
        if leftLabelTopLocation {
            labelTopContainerView.addSubview(leftLabel)
            removeLabelFromContainer(label: leftLabel, container: labelBottomContainerView)
        }else {
            labelBottomContainerView.addSubview(leftLabel)
            removeLabelFromContainer(label: leftLabel, container: labelTopContainerView)
        }
    }
    
    fileprivate func updateRightLabelLocation(){
        if rightLabelTopLocation {
            labelTopContainerView.addSubview(rightLabel)
            removeLabelFromContainer(label: rightLabel, container: labelBottomContainerView)
        }else {
            labelBottomContainerView.addSubview(rightLabel)
            removeLabelFromContainer(label: rightLabel, container: labelTopContainerView)
        }
    }
    
    fileprivate func removeLabelFromContainer(label:UILabel, container:UIView){
        for currView in container.subviews{
            if currView == label{
                currView.removeFromSuperview()
            }
        }
    }
    
    fileprivate func updateLabelFrame(){
        //left
        leftLabel.frame = CGRect(x: slider.leftLocation.x,
                                 y: 0.0,
                                 width: labelWidth,
                                 height: leftLabel.frame.size.height)
        
        //right
        rightLabel.frame = CGRect(x: slider.rightLocation.x,
                                  y: 0.0,
                                  width: labelWidth,
                                  height: rightLabel.frame.size.height)
    }
    
    func requestUpdatedValues(){
        delegate?.sliderValueChanged(slider: slider,
                                     label: leftLabel,
                                     value: slider.leftValue)
        
        
        delegate?.sliderValueChanged(slider: slider,
                                     label: rightLabel,
                                     value: slider.rightValue)
    }
}

//MARK: - RangeSliderDelegate
extension RangeSliderWithLabels:RangeSliderDelegate{
    func sliderLeftChanged(slider: RangeSlider) {
        if slider == self.slider{
            let calcPoint = calculatePointBasedOnOverflowPossibility(locationPoint: slider.leftLocation.x,
                                                                     label: leftLabel)
            
            leftLabel.frame = CGRect(x: calcPoint,
                                     y: 0.0,
                                     width: leftLabel.frame.size.width,
                                     height: leftLabel.frame.size.height)
            
            
            delegate?.sliderValueChanged(slider: slider,
                                         label: leftLabel,
                                         value: slider.leftValue)
        }
    }
    
    func sliderRightChanged(slider: RangeSlider) {
        if slider == self.slider{
            
            let calcPoint = calculatePointBasedOnOverflowPossibility(locationPoint: slider.rightLocation.x,
                                                                     label: rightLabel)
            
                rightLabel.frame = CGRect(x: calcPoint,
                                          y: 0.0,
                                          width: rightLabel.frame.size.width,
                                          height: rightLabel.frame.size.height)
            
            delegate?.sliderValueChanged(slider: slider,
                                         label: rightLabel,
                                         value: slider.rightValue)
        }
    }
    
    fileprivate func calculatePointBasedOnOverflowPossibility(locationPoint:CGFloat,
                                        label:UILabel)->CGFloat{
        
        //right overflow
        let rightOverFlow = locationPoint + label.frame.size.width
        if ( rightOverFlow > view.frame.size.width){
            let calc =  locationPoint - (rightOverFlow - view.frame.size.width)
            return calc
        }
        //left overflow
        else if locationPoint < view.frame.origin.x {
            //TODO: left overflow
        }
        
        return locationPoint
    }
}



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
    @IBOutlet weak var labelContainerView: UIView!
    @IBOutlet weak var sliderContainerView: UIView!
    
    //MARK: - Properties
    var leftLabel:UILabel! = UILabel(frame: CGRect.zero)
    var rightLabel:UILabel! = UILabel(frame: CGRect.zero)
    var view:UIView!
    var slider:RangeSlider = RangeSlider(frame: CGRect.zero)
    weak var delegate:RangeSliderWithLabelsDelegate?
    
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
        
        sliderContainerView.backgroundColor = .clear
        labelContainerView.backgroundColor = .clear
        view.backgroundColor = .clear
        
        leftLabel.text  = ""
        rightLabel.text = ""
        
        labelContainerView.addSubview(leftLabel)
        labelContainerView.addSubview(rightLabel)
        
        setSlider()
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
        slider.delegate = self
        slider.frame = CGRect(x: 0.0,
                              y: 0,
                              width: view.frame.size.width,
                              height: sliderContainerView.frame.size.height)
        sliderContainerView.addSubview(slider)
        
        //updating labels location
        leftLabel.frame = CGRect(x: slider.leftLocation.x,
                                y: 0.0,
                                width: 100,
                                height: labelContainerView.frame.size.height)
        
        rightLabel.frame = CGRect(x: slider.rightLocation.x,
                                 y: 0.0,
                                 width: 100,
                                 height: labelContainerView.frame.size.height)
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
            leftLabel.frame = CGRect(x: slider.leftLocation.x,
                                     y: 0.0,
                                     width: 100,
                                     height: leftLabel.frame.size.height)
            
            delegate?.sliderValueChanged(slider: slider,
                                         label: leftLabel,
                                         value: slider.leftValue)
        }
    }
    
    func sliderRightChanged(slider: RangeSlider) {
        if slider == self.slider{
            rightLabel.frame = CGRect(x: slider.rightLocation.x,
                                      y: 0.0,
                                      width: 100,
                                      height: rightLabel.frame.size.height)
            delegate?.sliderValueChanged(slider: slider,
                                         label: rightLabel,
                                         value: slider.rightValue)
        }
    }
}



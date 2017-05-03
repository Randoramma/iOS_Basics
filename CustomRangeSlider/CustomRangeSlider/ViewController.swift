//
//  ViewController.swift
//  CustomRangeSlider
//
//  Created by lu on 5/1/17.
//  Copyright © 2017 lu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var slider2View: UIView!
    @IBOutlet weak var sliderViewWithLabels: RangeSliderWithLabels!
    
    //MARK: - Properties
    let slider1LeftLabel: UILabel   = UILabel(frame: CGRect.zero)
    let slider1RightLabel: UILabel  = UILabel(frame: CGRect.zero)
    let range1Slider    = RangeSlider(frame: CGRect.zero)
    
    let sliderWithNoLabels = RangeSlider(frame: CGRect.zero)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setSliderWithLabelsManuallyRelocated()
        
        setSliderWithNoLabels()
        
        setSliderWithLabelsAutoRelocated()
    }
    
    func setSliderWithLabelsManuallyRelocated(){
        range1Slider.delegate = self
        range1Slider.frame = CGRect(x: 0.0,
                                    y: sliderView.frame.size.height/2,
                                    width: sliderView.frame.size.width,
                                    height: sliderView.frame.size.height/2)
        sliderView.addSubview(range1Slider)
        
        //adding labels
        sliderView.addSubview(slider1LeftLabel)
        sliderView.addSubview(slider1RightLabel)
        
        //updating labels location
        slider1LeftLabel.frame = CGRect(x: range1Slider.leftLocation.x,
                                        y: 0.0,
                                        width: 100,
                                        height: sliderView.frame.size.height/2)
        
        
        slider1RightLabel.frame = CGRect(x: range1Slider.rightLocation.x,
                                         y: 0.0,
                                         width: 100,
                                         height: sliderView.frame.size.height/2)
        
        //updating labels values
        let slider1LeftValue:Double = round(range1Slider.leftValue * 100) / 100
        slider1LeftLabel.text = "\(slider1LeftValue)"
        
        let slider1RightValue:Double = round(range1Slider.rightValue * 100) / 100
        slider1RightLabel.text = "\(slider1RightValue)"
    }
    
    func setSliderWithLabelsAutoRelocated(){
        sliderViewWithLabels.delegate = self
        sliderViewWithLabels.slider.curvaceousness = 2.0
        sliderViewWithLabels.slider.handleTintColor = .cyan
        sliderViewWithLabels.slider.trackTintColor = .blue
        sliderViewWithLabels.setNeedsLayout()
        sliderViewWithLabels.layoutIfNeeded()
        
        //get initial values
        sliderViewWithLabels.requestUpdatedValues()
    }
    
    
    /*
     Ideal for sliders that no label is desired
     */
    func setSliderWithNoLabels(){
        sliderWithNoLabels.delegate = self
        sliderWithNoLabels.frame = CGRect(x: 0.0,
                                          y: slider2View.frame.size.height/2,
                                          width: slider2View.frame.size.width,
                                          height: slider2View.frame.size.height/2)
        slider2View.addSubview(sliderWithNoLabels)
        
        sliderWithNoLabels.trackTintColor = UIColor.darkGray
        sliderWithNoLabels.handleTintColor = UIColor.blue
        sliderWithNoLabels.trackHighlightTintColor = UIColor.red
        sliderWithNoLabels.curvaceousness = 0.0
    }
}

//MARK: - RangeSliderWithLabelsDelegate
extension ViewController: RangeSliderWithLabelsDelegate {
    func sliderValueChanged(slider: RangeSlider,
                            label: UILabel,
                            value: Double) {
        if slider == sliderViewWithLabels.slider {
            let valueRounded = round(value * 10) / 10
            label.text = String("#")?.appending(String(valueRounded))
        }
    }
}

//MARK: - RangeSliderDelegate
extension ViewController: RangeSliderDelegate {
    func sliderLeftChanged(slider:RangeSlider){
        
        let leftLocation = slider.leftLocation
        let leftValue:Double = round(slider.leftValue * 100) / 100
        
        if slider == self.range1Slider{
            print("slider 1!")
            
            slider1LeftLabel.text = "\(leftValue)"
            
            slider1LeftLabel.frame = CGRect(x: leftLocation.x,
                                            y: 0.0,
                                            width: 100,
                                            height: sliderView.frame.size.height/2)
        }
        else if slider == self.sliderWithNoLabels {
            print("sliderWithNoLabels!")
        }
        
        print("left value: ", leftValue)
        print("left point: ", leftLocation)
    }
    
    func sliderRightChanged(slider:RangeSlider){
        
        let rightLocation:CGPoint = slider.rightLocation
        let rightValue:Double = round(slider.rightValue * 100) / 100
        
        if slider == self.range1Slider{
            print("slider 1!")
            
            slider1RightLabel.text = "\(rightValue)"
            
            slider1RightLabel.frame = CGRect(x: rightLocation.x,
                                             y: 0.0,
                                             width: 100,
                                             height: sliderView.frame.size.height/2)
        }
        else if slider == self.sliderWithNoLabels {
            print("sliderWithNoLabels!")
        }
        
        print("right value: ", rightValue)
        print("right point: ", rightLocation)
    }
}

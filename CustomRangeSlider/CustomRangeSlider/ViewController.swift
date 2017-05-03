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
    @IBOutlet weak var slider3View: UIView!
    
    //MARK: - Properties
    let slider1LeftLabel: UILabel = UILabel(frame: CGRect.zero)
    let slider1RightLabel: UILabel = UILabel(frame: CGRect.zero)
    let range1Slider    = RangeSlider(frame: CGRect.zero)
    let range2Slider    = RangeSlider(frame: CGRect.zero)
    let range3Slider    = RangeSlider(frame: CGRect.zero)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //slider 1
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
        
        
        //slider 2
        range2Slider.delegate = self
        range2Slider.frame = CGRect(x: 0.0,
                                   y: slider2View.frame.size.height/2,
                                   width: slider2View.frame.size.width,
                                   height: slider2View.frame.size.height/2)
        slider2View.addSubview(range2Slider)
        
        range2Slider.trackTintColor = UIColor.darkGray
        range2Slider.handleTintColor = UIColor.blue
        range2Slider.trackHighlightTintColor = UIColor.red
        range2Slider.curvaceousness = 0.0

        //slider 3
        range3Slider.delegate = self
        range3Slider.frame = CGRect(x: 0.0,
                                    y: slider3View.frame.size.height/2,
                                    width: slider3View.frame.size.width,
                                    height: slider3View.frame.size.height/2)
        slider3View.addSubview(range3Slider)
    }
}

//MARK: - RangeSliderDelegate
extension ViewController: RangeSliderDelegate {
    func leftValueChanged(slider:RangeSlider,
                          value:Double,
                          point:CGPoint){
        if slider == self.range1Slider{
            print("slider 1!")
            
            let slider1LeftValue:Double = round(range1Slider.leftValue * 100) / 100
            slider1LeftLabel.text = "\(slider1LeftValue)"
            
            slider1LeftLabel.frame = CGRect(x: range1Slider.leftLocation.x,
                                            y: 0.0,
                                            width: 100,
                                            height: sliderView.frame.size.height/2)
        }
        else if slider == self.range2Slider {
            print("slider 2!")
        }
        else if slider == self.range3Slider {
            print("slider 3!")
        }
        print("left value: ", value)
        print("left point: ", point)
    }
    
    func rightValueChanged(slider:RangeSlider,
                           value:Double,
                           point:CGPoint){
        if slider == self.range1Slider{
            print("slider 1!")
            
            let slider1RightValue:Double = round(range1Slider.rightValue * 100) / 100
            slider1RightLabel.text = "\(slider1RightValue)"
            
            slider1RightLabel.frame = CGRect(x: range1Slider.rightLocation.x,
                                             y: 0.0,
                                             width: 100,
                                             height: sliderView.frame.size.height/2)
        }
        else if slider == self.range2Slider {
            print("slider 2!")
        }
        else if slider == self.range3Slider {
            print("slider 3!")
        }
        print("right value: ", value)
        print("right point: ", point)
    }
}

//MARK: - Notifications
extension ViewController {
    func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        if rangeSlider == self.range1Slider{
            print("slider 1!")
        }
        else if rangeSlider == self.range2Slider {
            print("slider 2!")
        }
        else if rangeSlider == self.range3Slider {
            print("slider 3!")
        }
        
        print("left: ", rangeSlider.leftValue)
        print("right: ", rangeSlider.rightValue)
    }
}


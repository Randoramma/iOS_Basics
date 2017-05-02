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
    let rangeSlider     = RangeSlider(frame: CGRect.zero)
    let range2Slider    = RangeSlider(frame: CGRect.zero)
    let range3Slider    = RangeSlider(frame: CGRect.zero)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
 
        subscribeToNotifications()
        
//        let time = DispatchTime.now() + Double(Int64(NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
//        DispatchQueue.main.asyncAfter(deadline: time) {
//        }
    }
    
    override func viewDidLayoutSubviews() {
        
//        //slider 1
//        rangeSlider.frame = CGRect(x: 0.0,
//                                   y: 0.0,
//                                   width: sliderView.frame.size.width,
//                                   height: sliderView.frame.size.height)
//        sliderView.addSubview(rangeSlider)
//        
//        
//        
//        //slider 2
//        range2Slider.frame = CGRect(x: 0.0,
//                                   y: 0.0,
//                                   width: slider2View.frame.size.width,
//                                   height: slider2View.frame.size.height)
//        slider2View.addSubview(range2Slider)
//        
//        self.range2Slider.trackTintColor = UIColor.darkGray
//        self.range2Slider.handleTintColor = UIColor.blue
//        self.range2Slider.trackHighlightTintColor = UIColor.red
//        self.range2Slider.curvaceousness = 0.0
//        
        
        
        //slider 3
        range3Slider.frame = CGRect(x: 0.0,
                                    y: 0.0,
                                    width: slider3View.frame.size.width,
                                    height: slider3View.frame.size.height)
        slider3View.addSubview(range3Slider)
        
        self.range3Slider.trackHeight = 5
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsuscribeToNotifications()
    }
    
    //MARK: - Notifications
    func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        print("Range slider value changed:")
        print("left: \(rangeSlider.leftValue) ")
        print("right: \(rangeSlider.rightValue) ")
    }
    
    func subscribeToNotifications(){
        rangeSlider.addTarget(self,
                              action: #selector(ViewController.rangeSliderValueChanged(_:)),
                              for: .valueChanged)
    }
    
    func unsuscribeToNotifications(){
        rangeSlider.removeTarget(self,
                                 action: #selector(ViewController.rangeSliderValueChanged(_:)),
                                 for: .valueChanged)
    }
}


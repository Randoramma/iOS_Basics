//
//  CustomView.swift
//  ReUsableUIView
//
//  Created by Luis Castillo on 2/21/17.
//  Copyright © 2017 devbros. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    //MARK: - UI Properties
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myButton: UIButton!
    
    //MARK: - Properties
    var view:UIView!
    
    //MARK: - Init
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        setup()
    }
    
    func setup(){
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView{
        let bundle = Bundle(for:type(of: self))
        let nib = UINib(nibName: "CustomView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

    //MARK: - Actions
    @IBAction func changeBackgroundColor(_ sender: Any){
        let color = UIColor(red: random(),
                            green: random(),
                            blue:  random(),
                            alpha: 1.0)
        
        view.backgroundColor = color
    }
    
    func random() -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
}

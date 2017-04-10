//
//  CustomSearchBar.swift
//  tableviews
//
//  Created by lu on 4/7/17.
//  Copyright © 2017 lc. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {
    
    //MARK: - Properties
    var preferredFont: UIFont!
    var preferredTextColor: UIColor!
    var preferredTintColor: UIColor!
    let lineLayerWidth:CGFloat      = 2.5
    
    var topAndBottomStart:CGFloat   = 5.0 {
        didSet{
            setSearchBarTextfield()
        }
    }
    var sidePaddingAmount:CGFloat   = 10.0 {
        didSet{
            setSearchBarTextfield()
        }
    }
    
    //MARK: - Init
    init(frame: CGRect,
         font: UIFont,
         textColor: UIColor,
         tintColor: UIColor,
         style:UISearchBarStyle,
         translucent:Bool) {
        super.init(frame: frame)
        
        self.frame          = frame
        preferredFont       = font
        preferredTextColor  = textColor
        preferredTintColor  = tintColor
        
        isTranslucent       = translucent
        searchBarStyle      = style
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        setSearchBarTextfield()
        
        //start/end point
        let startPoint  = CGPoint(x: 0.0,
                                  y: frame.size.height)
        let endPoint    = CGPoint(x: frame.size.width,
                                  y: frame.size.height)
        let path        = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        
        //line layer
        let shapeLayer          = CAShapeLayer()
        shapeLayer.path         = path.cgPath
        shapeLayer.strokeColor  = preferredTextColor.cgColor
        shapeLayer.lineWidth    = lineLayerWidth
        layer.addSublayer(shapeLayer)
        
        super.draw(rect)
    }
    
    //MARK: - Search Bar Configurations
    fileprivate func setSearchBarTextfield(){
        let firstView:UIView = subviews[0]
        
        for currView in firstView.subviews {
            if let searchField:UITextField = currView as? UITextField {
                setStyleFor(textfield: searchField)
            }
        }
    }
    
    fileprivate func setStyleFor(textfield:UITextField){
        //frame
        let widthWithPadding    = (frame.size.width - sidePaddingAmount)
        let heightWithPadding   = (frame.size.height - sidePaddingAmount)
        textfield.frame = CGRect(x: topAndBottomStart,
                                 y: topAndBottomStart,
                                 width: widthWithPadding,
                                 height: heightWithPadding)
        
        //font and text color
        textfield.font        = preferredFont
        textfield.textColor   = preferredTextColor
        
        //background color
        textfield.backgroundColor = preferredTintColor
    }
}

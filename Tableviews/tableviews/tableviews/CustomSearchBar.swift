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
    var preferredPlaceHolderTextColor: UIColor!
    var preferredSeperatorColor: UIColor!
    let lineLayerWidth:CGFloat      = 2.5
    
    var topAndBottomStart:CGFloat   = 5.0 {
        didSet{
            setSearchBarStyles()
        }
    }
    var sidePaddingAmount:CGFloat   = 10.0 {
        didSet{
            setSearchBarStyles()
        }
    }
    
    //MARK: - Init
    init(frame: CGRect,
         font: UIFont,
         placeholderTextColor: UIColor = UIColor.gray,
         tintColor: UIColor,
         backgroundTintColor: UIColor,
         backgroundColor: UIColor,
         clearBackground:Bool = false,
         seperatorColor:UIColor? = nil,
         style:UISearchBarStyle,
         isTranslucent:Bool) {
        super.init(frame: frame)
        
        self.frame              = frame
        
        self.tintColor          = tintColor
        self.barTintColor       = backgroundTintColor
        self.backgroundColor    = backgroundColor
        
        //clear background option
        if clearBackground || (backgroundColor == UIColor.clear){
            self.backgroundImage = UIImage()
            self.backgroundColor = UIColor.clear
        }
        
        //defaults
        preferredSeperatorColor         = tintColor
        preferredPlaceHolderTextColor   = placeholderTextColor
        
        //custom
        preferredFont       = font
        if preferredSeperatorColor != nil {
            preferredSeperatorColor = seperatorColor
        }
        
        preferredPlaceHolderTextColor = placeholderTextColor
        
        self.searchBarStyle = style
        self.isTranslucent  = isTranslucent
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        setSearchBarStyles()
        
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
        shapeLayer.strokeColor  = preferredSeperatorColor.cgColor
        shapeLayer.lineWidth    = lineLayerWidth
        layer.addSublayer(shapeLayer)
        
        
        
        super.draw(rect)
    }
    
    //MARK: - Search Bar Configurations
    fileprivate func setSearchBarStyles(){
        let firstView:UIView = subviews[0]
        
        for currView in firstView.subviews {
            if let searchField:UITextField = currView as? UITextField {
                setStyleFor(textfield: searchField)
            }
            else if let searchButton:UIButton = currView as? UIButton {
                setStyleFor(button:searchButton)
            }
        }
    }
    
    fileprivate func setStyleFor(button:UIButton){
        button.setTitleColor(preferredPlaceHolderTextColor, for: .disabled)
    }
    
    fileprivate func setStyleFor(textfield:UITextField){
        //frame
        let widthWithPadding    = (frame.size.width - sidePaddingAmount)
        let heightWithPadding   = (frame.size.height - sidePaddingAmount)
        textfield.frame = CGRect(x: topAndBottomStart,
                                 y: topAndBottomStart,
                                 width: widthWithPadding,
                                 height: heightWithPadding)
        
        //search icon color
        if let leftView:UIImageView = textfield.leftView as? UIImageView{
            leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
            leftView.tintColor = tintColor
        }
        
        //font and text color
        textfield.font        = preferredFont
        textfield.textColor   = tintColor
        
        //background color
        textfield.backgroundColor = backgroundColor
        
        //placeholder text
        let attributes:[String:UIColor] = [ NSForegroundColorAttributeName : preferredPlaceHolderTextColor ]
        let placeholderValue:String     = (placeholder != nil) ? (placeholder!) : ""
        textfield.attributedPlaceholder = NSAttributedString(string: placeholderValue,
                                                             attributes: attributes)
        
    }
}

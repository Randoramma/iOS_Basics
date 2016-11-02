//
//  TextfieldAndButtons
//
//  Created by Luis Castillo on 11/1/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit
import Foundation


extension UIButton
{
    //MARK: - Round
    func addRoundBorder(color:UIColor, borderWidth:CGFloat)
    {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
        
        self.layer.cornerRadius = self.frame.size.height/2
    }//eom
    
    func addBorder(color:UIColor, borderWidth:CGFloat)
    {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
    }//eom
   
    //MARK: - Left/Right
    func addLeftBorder(color:UIColor, borderWidth:CGFloat)
    {
        let estFrame:CGRect = CGRect(x: 0, y: 0, width: borderWidth, height: self.frame.size.height)
        
        let newBorder:CALayer = CALayer()
        newBorder.backgroundColor = color.cgColor
        newBorder.frame = estFrame
        
        self.layer.addSublayer(newBorder)
    }//eom
    
    func addRightBorder(color:UIColor, borderWidth:CGFloat)
    {
        let estX:CGFloat = self.frame.size.width - borderWidth
        let estFrame:CGRect = CGRect(x: estX, y: 0, width: borderWidth, height: self.frame.size.height)
        
        let newBorder:CALayer = CALayer()
        newBorder.backgroundColor = color.cgColor
        newBorder.frame = estFrame
        
        self.layer.addSublayer(newBorder)
    }//eom
    
    //MARK: - Top/Bottom
    func addTopBorder(color:UIColor, borderWidth:CGFloat)
    {
        let estFrame:CGRect = CGRect(x: 0, y: 0, width: self.frame.size.width, height: borderWidth)
        
        //        let layerView:UIView = UIView()
        //        layerView.backgroundColor = color
        //        layerView.frame = estFrame
        //        self .addSubview(layerView)
        
        let newBorder:CALayer = CALayer()
        newBorder.backgroundColor = color.cgColor
        newBorder.frame = estFrame
        
        super.layer .addSublayer(newBorder)
    }//eom
    
    func addBottomBorder(color:UIColor, borderWidth:CGFloat)
    {
        let estY:CGFloat = self.frame.size.height - borderWidth
        let estFrame:CGRect = CGRect(x: 0, y: estY, width: self.frame.size.width, height: borderWidth)
        
        let newBorder:CALayer = CALayer()
        newBorder.backgroundColor = color.cgColor
        newBorder.frame = estFrame
        
        self.layer.addSublayer(newBorder)
    }//eom
    
}//eo

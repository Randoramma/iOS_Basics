//
//  textfield+layers.swift
//  TextfieldAndButtons
//
//  Created by Luis Castillo on 11/2/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

extension UITextField
{
    
    //MARK: - No Border
    func removeBorders()
    {
        self.borderStyle = UITextBorderStyle.none
    
    }//eom
    

    //MARK: - Top/Bottom
    func addBottomBorder(color:UIColor, borderWidth:CGFloat)
    {
        let estY:CGFloat = self.frame.size.height - borderWidth
        let estFrame:CGRect = CGRect(x: 0, y: estY, width: self.frame.size.width, height: self.frame.size.height)
        
        let borderLayer:CALayer = CALayer ()
        borderLayer.borderWidth = borderWidth
        borderLayer.backgroundColor = color.cgColor
        borderLayer.frame = estFrame
        
        self.layer.addSublayer(borderLayer)
        self.layer.masksToBounds = true
    }//eom

}

//
//  UIbutton+tintImage.swift
//  avFoundationExample
//
//  Created by Luis Castillo on 2/15/16.
//  Copyright © 2016 LC. All rights reserved.
//

/*
from:
    https://github.com/filipstefansson/UITintedButton
*/

import UIKit

extension UIButton
{
    //MARK: Image Tint
    func setImageTintColor(_ color: UIColor, forState:UIControlState)
    {
        if ((self.imageView?.image) != nil)
        {
            guard var tintedImage:UIImage = self.image(for: forState) else { return }
            tintedImage = self.tintedImageWithColor(color, image: tintedImage)
            self .setImage(tintedImage, for: forState)
        }
        else
        {
            print("UIButton does not have any image to tint")
        }
    }//eom
    
    fileprivate func tintButtonImages(_ buttons:NSArray , withColor:(UIColor), forState:UIControlState)
    {
        for button in buttons
        {
            if let currButton = button as? UIButton
            {
                currButton .setImageTintColor(withColor, forState: forState)
            }
        }//eofl
    }//eom
    
    //MARK: Background Tint
    func setBackgroundTintColor(_ color: UIColor, forState:UIControlState)
    {
        if (self.backgroundImage(for: forState) != nil)
        {
            guard let image:UIImage = self.backgroundImage(for: forState) else { return }
            let backgroundImage:UIImage = self.tintedImageWithColor(color, image: image)
            self.setBackgroundImage(backgroundImage, for: forState)
        }
        else
        {
            print("UIButton does not have any background image to tint")
        }
    }//eom
    
    fileprivate func tintButtonBackgrounds(_ buttons:NSArray , withColor:(UIColor), forState:UIControlState)
    {
        for button in buttons
        {
            if let currButton = button as? UIButton
            {
                currButton .setBackgroundTintColor(withColor, forState: forState)
            }
        }//eofl
    }//eom
    
    //MARK: Tint 
    func tintedImageWithColor( _ tintColor:UIColor, image:UIImage )->UIImage
    {
        UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
        
        guard let context:CGContext = UIGraphicsGetCurrentContext() else { return UIImage() }
        
        context.translateBy(x: 0, y: image.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        let rect:CGRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        
        // draw alpha-mask
        context.setBlendMode(CGBlendMode.normal);
        context.draw(image.cgImage!, in: rect);
        
        // draw tint color, preserving alpha values of original image
        context.setBlendMode(CGBlendMode.sourceIn);
        tintColor.setFill()
        context.fill(rect);
        
        let coloredImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        
        return coloredImage;
    }//eom
}

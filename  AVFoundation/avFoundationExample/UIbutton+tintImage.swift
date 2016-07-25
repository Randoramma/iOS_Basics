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
    func setImageTintColor(color: UIColor, forState:UIControlState)
    {
        if ((self.imageView?.image) != nil)
        {
            guard var tintedImage:UIImage = self.imageForState(forState) else { return }
            tintedImage = self.tintedImageWithColor(color, image: tintedImage)
            self .setImage(tintedImage, forState: forState)
        }
        else
        {
            print("UIButton does not have any image to tint")
        }
    }//eom
    
    private func tintButtonImages(buttons:NSArray , withColor:(UIColor), forState:UIControlState)
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
    func setBackgroundTintColor(color: UIColor, forState:UIControlState)
    {
        if (self.backgroundImageForState(forState) != nil)
        {
            guard let image:UIImage = self.backgroundImageForState(forState) else { return }
            let backgroundImage:UIImage = self.tintedImageWithColor(color, image: image)
            self.setBackgroundImage(backgroundImage, forState: forState)
        }
        else
        {
            print("UIButton does not have any background image to tint")
        }
    }//eom
    
    private func tintButtonBackgrounds(buttons:NSArray , withColor:(UIColor), forState:UIControlState)
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
    func tintedImageWithColor( tintColor:UIColor, image:UIImage )->UIImage
    {
        UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.mainScreen().scale)
        
        guard let context:CGContextRef = UIGraphicsGetCurrentContext() else { return UIImage() }
        
        CGContextTranslateCTM(context, 0, image.size.height)
        CGContextScaleCTM(context, 1.0, -1.0)
        
        let rect:CGRect = CGRectMake(0, 0, image.size.width, image.size.height)
        
        // draw alpha-mask
        CGContextSetBlendMode(context,   CGBlendMode.Normal);
        CGContextDrawImage(context, rect, image.CGImage);
        
        // draw tint color, preserving alpha values of original image
        CGContextSetBlendMode(context, CGBlendMode.SourceIn);
        tintColor.setFill()
        CGContextFillRect(context, rect);
        
        let coloredImage:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return coloredImage;
    }//eom
}

//
//  resizeImage.swift
//  avFoundationExample
//
//  Created by Luis Castillo on 2/19/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit
import Foundation

class resizeImage: NSObject
{
    var thumbnailImageData:NSData   = NSData()
    var resized:UIImage             = UIImage()
    
    
    func resizeImage( image:UIImage, resizeWidth:CGFloat, resizeHeight:CGFloat )->UIImage
    {
        UIGraphicsBeginImageContext(CGSizeMake(resizeWidth, resizeHeight))
        
        image .drawInRect(CGRectMake(0, 0, resizeWidth, resizeHeight))
        resized = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resized
    }//eom
    
    
    func getThumbnailImageData()->NSData
    {
        if let imageData:NSData = UIImageJPEGRepresentation(resized, 0.7)
        {
            thumbnailImageData = imageData
        }
        
        return thumbnailImageData
    }//eom
    
    // MARK: - Image Two Function
    func resizeImageTwo(image: UIImage, newWidth: CGFloat) -> UIImage
    {
        let scale       = newWidth / image.size.width
        let newHeight   = image.size.height * scale
        
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }//eom

    
}//eoc

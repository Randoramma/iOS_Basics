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
    var thumbnailImageData:Data   = Data()
    var resized:UIImage             = UIImage()
    
    
    func resizeImage( _ image:UIImage, resizeWidth:CGFloat, resizeHeight:CGFloat )->UIImage
    {
        UIGraphicsBeginImageContext(CGSize(width: resizeWidth, height: resizeHeight))
        
        image .draw(in: CGRect(x: 0, y: 0, width: resizeWidth, height: resizeHeight))
        resized = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return resized
    }//eom
    
    
    func getThumbnailImageData()->Data
    {
        if let imageData:Data = UIImageJPEGRepresentation(resized, 0.7)
        {
            thumbnailImageData = imageData
        }
        
        return thumbnailImageData
    }//eom
    
    // MARK: - Image Two Function
    func resizeImageTwo(_ image: UIImage, newWidth: CGFloat) -> UIImage
    {
        let scale       = newWidth / image.size.width
        let newHeight   = image.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }//eom

    
}//eoc

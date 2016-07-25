//
//  UIImage+cropAndResize.swift
//  avFoundationExample
//
//  Created by Luis Castillo on 2/15/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

extension  UIImage
{
    
    func croppedImage(bounds:CGRect)->UIImage
    {
        var croppedImage:UIImage = UIImage()
        
        if let imageRef:CGImageRef = CGImageCreateWithImageInRect(self.CGImage, bounds)
        {
            switch(self.imageOrientation)
            {
            case .Down:
                print("[cropping] Image Down")
                 croppedImage = UIImage(CGImage: imageRef, scale: 1.0, orientation: UIImageOrientation.Down)
                break
            case .Up:
                print("[cropping] Image Up")
                 croppedImage = UIImage(CGImage: imageRef, scale: 1.0, orientation: UIImageOrientation.Up)
                break
            case .Left:
                print("[cropping] Image Left")
                 croppedImage = UIImage(CGImage: imageRef, scale: 1.0, orientation: UIImageOrientation.Left)
                break
            case .Right:
                print("[cropping] Image Right")
                 croppedImage = UIImage(CGImage: imageRef, scale: 1.0, orientation: UIImageOrientation.Right)
                break
            default :
                print("undetermined orientation")
                 croppedImage = UIImage(CGImage: imageRef)
                break
            }
        }
        
        return croppedImage
    }//eom
    
    
    
    
    
    
    /*  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  */
    
    
    func imageByScalingAndCroppingForSizeWithCenter(targetSize:CGSize) -> UIImage
    {
        let sourceImage:UIImage     = self
        var newImage:UIImage        = UIImage()
        let imageSize:CGSize        = sourceImage.size
        let width:CGFloat           = imageSize.width
        let height:CGFloat          = imageSize.height
        let targetWidth:CGFloat     = imageSize.width
        let targetHeight:CGFloat    = imageSize.height
        var scaleFactor:CGFloat     = 0.0
        var scaledWidth:CGFloat     = targetWidth
        var scaledHeight:CGFloat    = targetHeight
        var thumbnailPoint:CGPoint  = CGPointMake(0.0, 0.0)
        
        if ( CGSizeEqualToSize(imageSize, targetSize) == false )
        {
            let widthFactor:CGFloat     = targetWidth / width
            let heightFactor:CGFloat    = targetHeight / height
            
            if ( widthFactor > heightFactor )
            {
                scaleFactor = widthFactor // scale to fit height
            }
            else
            {
                scaleFactor = heightFactor // scale to fit width
            }
            
            scaledWidth  = width * scaleFactor
            scaledHeight = height * scaleFactor
            
            // center the image
            if( widthFactor > heightFactor )
            {
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5
            }
            else
            {
                if (widthFactor < heightFactor)
                {
                    thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5
                }
            }
        }//eo
        
        // cropping image
        UIGraphicsBeginImageContext(targetSize)
        
        var thumbnailRect:CGRect    = CGRectZero
        thumbnailRect.origin        = thumbnailPoint
        thumbnailRect.size.width    = scaledWidth
        thumbnailRect.size.height   = scaledHeight
        
        sourceImage.drawInRect(thumbnailRect)
            
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        //pop the context to get back to the default
        UIGraphicsEndImageContext()
        
        return newImage;
    }//eom

    func imageByScalingAndCroppingForSizeNoCenter(targetSize:CGSize) -> UIImage
    {
        let sourceImage:UIImage     = self
        var newImage:UIImage        = UIImage()
        let imageSize:CGSize        = sourceImage.size
        let width:CGFloat           = imageSize.width
        let height:CGFloat          = imageSize.height
        let targetWidth:CGFloat     = imageSize.width
        let targetHeight:CGFloat    = imageSize.height
        var scaleFactor:CGFloat     = 0.0
        var scaledWidth:CGFloat     = targetWidth
        var scaledHeight:CGFloat    = targetHeight
        var thumbnailPoint:CGPoint  = CGPointMake(0.0, 0.0)
        
        if ( CGSizeEqualToSize(imageSize, targetSize) == false )
        {
            let widthFactor:CGFloat     = targetWidth / width
            let heightFactor:CGFloat    = targetHeight / height
            
            if ( widthFactor > heightFactor )
            {
                scaleFactor = widthFactor // scale to fit height
            }
            else
            {
                scaleFactor = heightFactor // scale to fit width
            }
            
            scaledWidth  = width * scaleFactor
            scaledHeight = height * scaleFactor
            
//            // center the image
//            if( widthFactor > heightFactor )
//            {
//                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5
//            }
//            else
//            {
//                if (widthFactor < heightFactor)
//                {
//                    thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5
//                }
//            }
        }//eo
        
        // cropping image
        UIGraphicsBeginImageContext(targetSize)
        
        var thumbnailRect:CGRect    = CGRectZero
        thumbnailRect.origin        = thumbnailPoint
        thumbnailRect.size.width    = scaledWidth
        thumbnailRect.size.height   = scaledHeight
        
        sourceImage.drawInRect(thumbnailRect)
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        //pop the context to get back to the default
        UIGraphicsEndImageContext()
        
        return newImage;
    }//eom

    /*
    
    //NO tried Yet
    
    extension UIImage {
        public func resize(size:CGSize, completionHandler:(resizedImage:UIImage, data:NSData)->()) {
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), { () -> Void in
                var newSize:CGSize = size
                let rect = CGRectMake(0, 0, newSize.width, newSize.height)
                UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
                self.drawInRect(rect)
                let newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                let imageData = UIImageJPEGRepresentation(newImage, 0.5)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    completionHandler(resizedImage: newImage, data:imageData)
                })
            })
        }
    }
    */

}

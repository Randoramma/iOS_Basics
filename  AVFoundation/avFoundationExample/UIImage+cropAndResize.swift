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
    
    /*  */
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
        objective-c:
    
    - (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
    {
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
    CGFloat widthFactor = targetWidth / width;
    CGFloat heightFactor = targetHeight / height;
    
    if (widthFactor > heightFactor)
    {
    scaleFactor = widthFactor; // scale to fit height
    }
    else
    {
    scaleFactor = heightFactor; // scale to fit width
    }
    
    scaledWidth  = width * scaleFactor;
    scaledHeight = height * scaleFactor;
    
    // center the image
    if (widthFactor > heightFactor)
    {
    thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
    }
    else
    {
    if (widthFactor < heightFactor)
    {
    thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
    }
    }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil)
    {
    NSLog(@"could not scale image");
    }
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
    }
    */
    

}

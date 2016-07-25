//
//  SelectImageAndCropViewController.swift
//  cameraApp
//
//  Created by Luis Castillo on 2/19/16.
//  Copyright © 2016 devbros. All rights reserved.
//

import UIKit

class SelectImageAndCropViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var cropBounds: UIView!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var cropButton: UIButton!
    
    /* properties */
    
    //
    var screenXStart:CGFloat    = CGFloat.init(0)   //static
    var screenXEnd:CGFloat      = CGFloat.init(0)   //width of screen
    //
    var screenYStart:CGFloat    = CGFloat.init(0)   //after the nav bar
    var screenYEnd:CGFloat      = CGFloat.init(0)   //height of screen
    
    var croppedImage:UIImage = UIImage()
    
    // MARK: - View Loading
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        screenXEnd = UIScreen.mainScreen().bounds.width
        screenYEnd = UIScreen.mainScreen().bounds.height
        
//        if let navBarHeight:CGFloat = (self.navigationController?.navigationBar.bounds.height)
//        {
////            screenYStart = navBarHeight + CGFloat.init(20)
////            screenYStart = selectedImageView.frame.origin.y
//        }
        
        self.selectPicture()
    }//eom
    
    
    override func viewDidAppear(animated: Bool)
    {
        //setting crop bounds upper limit
        screenYStart = selectedImageView.frame.origin.y
        
        print("\ncropBounds: \(cropBounds.frame)")
        print("selectedImageView: \(selectedImageView.frame)\n")
    }//eom

    //MARK: - Select Picture
    func selectPicture()
    {
        var cameraPicker:UIImagePickerController    = UIImagePickerController()
        
        //device has camera
        if UIImagePickerController .isSourceTypeAvailable(.Camera)
        {
            cameraPicker                        = UIImagePickerController()
            cameraPicker.delegate               = self
            cameraPicker.sourceType             = UIImagePickerControllerSourceType.PhotoLibrary
            
            self.presentViewController(cameraPicker, animated: true, completion: nil)
        }
        else
        {
            print("no camera avaliable")
        }
    }//eom
    
    //MARK: - Image Picker Delegates
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        guard let origImage:UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        
        self.selectedImageView.image = origImage
        
        //checking if cropbound exceeds the new image
        print("new image size \(origImage.debugDescription)")
        print("imageView \(self.selectedImageView.debugDescription)")
        
        print("crop curr size \(self.cropBounds.frame.size)")
        
    }//eom
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }//eom
    
    //MARK: Handling Crop Bounds
    @IBAction func handlePlan(sender: UIPanGestureRecognizer)
    {
        switch(sender.state)
        {
            case UIGestureRecognizerState.Changed:
                let translation:CGPoint = sender .translationInView(self.view)
                
                //allow dragging only in Y coordinates by only updating the Y Coordinate with translation position
                guard let currCenter:CGPoint = sender.view?.center else { return }
                let calcCenter:CGPoint = CGPointMake(currCenter.x, (currCenter.y + translation.y) )
                sender.view?.center =  calcCenter
                
                sender .setTranslation(CGPointMake(0, 0), inView: self.view)
                
                //get the top of the edge coordinate for the top left corner of crop frame
                let topEdgePosition:CGFloat = CGRectGetMinY(cropBounds.frame)
                
                //get the bottom of the edge coordinate for the top left corner of crop frame
                let bottomEdgePosition:CGFloat = CGRectGetMaxY(cropBounds.frame)
                
                //if the top edge coordinate is less than or equal to 53
                    // if topEdgePosition <= 53
                 if topEdgePosition <= screenYStart
                {
                    //draw view in max top position
                    cropBounds.frame = CGRectMake(0, screenYStart, cropBounds.frame.width, cropBounds.frame.width)
                }
                
                
                //if bottom edge coordinate  is greater than or equal to 480
                // if bottomEdgePosition >= 460
                 if bottomEdgePosition >= screenYEnd
                 {
                    //draw view in max bottom position
                    cropBounds.frame = CGRectMake(0, (screenYEnd-screenXEnd), cropBounds.frame.width, cropBounds.frame.width)
                }
                
                // print("cropBounds Updated \(cropBounds.frame)")
                break;
            default:
                break;
        }
        
    }//eo-a
    
    
    
    //MARK: Crop Image
    @IBAction func cropImage(sender:UIButton)
    {
        if let imageToCrop:UIImage = selectedImageView.image
        {
            print("\nimageview: \(selectedImageView.frame)")
            print("image: \(imageToCrop.debugDescription)")
            print("crop bounds: \(cropBounds.frame)")
            
            let holderWidth:CGFloat  = selectedImageView.frame.width
            let holderHeight:CGFloat = selectedImageView.frame.height
            let holderYStart:CGFloat = CGRectGetMinY(selectedImageView.frame)
            
            let cropBoundWidth:CGFloat  = cropBounds.frame.width
            let cropBoundHeight:CGFloat = cropBounds.frame.height
            let cropBoundYStart:CGFloat = CGRectGetMinY(cropBounds.frame)
            
            let imgWidth:CGFloat = imageToCrop.size.width
            let imgHeight:CGFloat = imageToCrop.size.height
            
            let width:CGFloat   = ( imgWidth * (cropBoundWidth/holderWidth)      )
            let height:CGFloat  = ( imgHeight * (cropBoundHeight/holderHeight)   )
           
                print("\n")
                print("(( \(cropBoundYStart) - \(holderYStart)) /  \(holderHeight) ) *  \(imgHeight)")
            
            var ratioValue:CGFloat = roundFloatToTwoDecimals( (cropBoundYStart - holderYStart) )
//            var ratioValue:CGFloat = roundFloatToTwoDecimals( cropBoundYStart )
            
                print("(( \( ratioValue ) /  \(holderHeight) ) *  \(imgHeight)")
            
            ratioValue = roundFloatToTwoDecimals( (ratioValue / holderHeight) )
                print("( \(ratioValue) *  \(imgHeight) ")
            
            ratioValue = roundFloatToTwoDecimals( (ratioValue * imgHeight) )
                print("( \(ratioValue) ")
                print("\n")
            
            //let startY:CGFloat  = ((cropBoundYStart - holderYStart) /  holderHeight ) *  imgHeight
            
            var calcCropBound:CGRect = CGRectMake(0, ratioValue, width, height)
            
            print("calcCropBound: \(calcCropBound)")
            
            switch(imageToCrop.imageOrientation)
            {
            case .Down:
                print("[before_crop] Image Down")
//                calcCropBound.size.height   = width
//                calcCropBound.size.width    = height
                break
            case .Up:
                print("[before_crop] Image Up")
                print("Nothing to change")
                break
            case .Left:
                print("[before_crop] Image Left")
                break
            case .Right:
                print("[before_crop] Image Right")
                calcCropBound.origin.x      = calcCropBound.origin.y
                calcCropBound.origin.y      = calcCropBound.origin.x
                calcCropBound.size.height   = width
                calcCropBound.size.width    = height
                break
            default :
                print("[before_crop] undetermined orientation")
                break
            }
            
            print("new Bound: \(calcCropBound)")
            let newImage:UIImage = imageToCrop.croppedImage(calcCropBound)
            
            if let displayVC:DisplayCropImageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("displayCropImage") as? DisplayCropImageViewController
            {
                displayVC.imageToDisplay = newImage
                self.navigationController?.pushViewController(displayVC, animated: true)
            }
            
        }
    }//eo-a

    
    //MARK: Round 2 decimal places
    func roundFloatToTwoDecimals(number:CGFloat)->CGFloat
    {
        var ratioValue  = floor( number * 100 )
        ratioValue      = ratioValue / 100
        
        return ratioValue
    }//eom
    
    
    
    //MARK:
    
    func cropImageNow(imageToBeCrop:UIImage)
    {
        //testing
        if let imageData:NSData = UIImageJPEGRepresentation(imageToBeCrop, 0.7)
        {
            //get number of bytes in NSData
            let imageToCropDataSize:NSInteger = imageData.length
            print("original size \(imageToCropDataSize) bytes")
        }
        
        print("\ncropImageNow")
        
        print("cropBounds \(cropBounds)")
        
        //get top corner coordinate of crop frame
        let topEdgePosition:CGFloat = CGRectGetMinY(cropBounds.frame)
        
        //crop image to selected bounds
        let croppedRect:CGRect = CGRectMake(0, topEdgePosition, cropBounds.frame.size.width, cropBounds.frame.size.height)
        
        print("croppedRect \(croppedRect)")
        
        let tmp:CGImageRef = CGImageCreateWithImageInRect(imageToBeCrop .CGImage, croppedRect)!
        let croppedImage:UIImage = UIImage(CGImage: tmp)
        
        //convert cropped image into NSData object
        guard let croppedImageData:NSData = UIImageJPEGRepresentation(croppedImage, 0.7) else { return }
        
        if let imageToBeResize:UIImage = UIImage(data: croppedImageData)
        {
            self.resizeImageNow(imageToBeResize)
        }
    }//eom
    
    func resizeImageNow(imageToResize:UIImage)
    {
        print("resizeImageNow")
        print("image current size: \(imageToResize.size)")
        
        
        let resizedWidth:CGFloat    = cropBounds.frame.size.width
        let resizedHeight:CGFloat   = cropBounds.frame.size.height
        
        UIGraphicsBeginImageContext(CGSizeMake(resizedWidth, resizedHeight))
        imageToResize .drawInRect(CGRectMake(0, 0, resizedWidth, resizedHeight))
        let resizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        print("resized image size: \(resizedImage.size)")

        guard let resizedImageData:NSData = UIImageJPEGRepresentation(resizedImage, 0.7) else { return }
        
        guard let finalImage:UIImage = UIImage(data: resizedImageData) else { return }
        
        print("resized size \(resizedImageData.length) bytes ")
        
       if let displayVC:DisplayCropImageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("displayCropImage") as? DisplayCropImageViewController
       {
            displayVC.imageToDisplay = finalImage
            self.navigationController?.pushViewController(displayVC, animated: true)
        }
        
    }//eom
    
    /* GOOD */
    func ResizeImageThree(image: UIImage, targetSize: CGSize) -> UIImage
    {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what the orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio)
        {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }//eom
    
    /* GOOD */
    func ResizeImageFour(imageObj:UIImage, sizeChange:CGSize)-> UIImage
    {
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        imageObj.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }//eom
   
    
    /* Not Working */
    //    func getNeedImageFrom(image:UIImage , var rect:CGRect)->UIImage
    //    {
    //        var croppedImage:UIImage = UIImage()
    //
    //        var cropSize:CGSize     = rect.size
    //        let widthScale:CGFloat  = image.size.width / self.selectedImageView.bounds.size.width
    //        let heightScale:CGFloat = image.size.height / self.selectedImageView.bounds.size.height
    //
    //        let cropWidth:CGFloat  = rect.size.width * widthScale
    //        let cropHeight:CGFloat = rect.size.height * heightScale
    //        cropSize = CGSizeMake(cropWidth, cropHeight)
    //
    //        let cropPointWidth:CGFloat  = rect.origin.x * widthScale
    //        let cropPointHeight:CGFloat = rect.origin.y * heightScale
    //        let pointCrop:CGPoint = CGPointMake(cropPointWidth, cropPointHeight)
    //
    //        rect = CGRectMake(pointCrop.x, pointCrop.y, cropSize.width, cropSize.height)
    //
    //        if let subImage:CGImageRef     = CGImageCreateWithImageInRect(image.CGImage, rect)
    //        {
    //            croppedImage   = UIImage(CGImage: subImage)
    //        }
    //        
    //        return croppedImage
    //    }//eom
        
    
    
    
}//eoc

//
//  TakeAndCropImageViewController.swift
//  cameraApp
//
//  Created by Luis Castillo on 2/19/16.
//  Copyright © 2016 devbros. All rights reserved.
//

import UIKit

class TakeAndCropImageViewController: UIViewController
{
    @IBOutlet weak var pictureTakenView: UIView!
    @IBOutlet weak var croppedImageView: UIImageView!
    @IBOutlet weak var cropButton: UIButton!
    @IBOutlet weak var takePictureButton: UIButton!

    var imageToCrop:UIImage   = UIImage()
    var imageToResize:UIImage = UIImage()
    
    // MARK: - View Loading
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setupAndTakePicture()
    }//eom

    
    
    @IBAction func takePictureOrVideo(sender: AnyObject)
    {
        self.cropButton.hidden = false
        self.cameraPicker.takePicture()
    }//eo-a
    

    //MARK: - Image Picker Delegates
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        guard let origImage:UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }

//        print("\norigImage: \(origImage.debugDescription)")
//        print("\ncameraPicker: \(cameraPicker.view.debugDescription)")
//        print("\npictureTakenView: \(self.pictureTakenView.debugDescription)")
//        print("\nmainScreen: \(UIScreen.mainScreen().debugDescription)")

        //remove elements from picture/video View
        for currView in self.pictureTakenView.subviews
        {
            currView.removeFromSuperview()
        }

        let imageView:UIImageView = UIImageView(frame: CGRectMake(pictureTakenView.frame.origin.x, pictureTakenView.frame.origin.y, pictureTakenView.frame.size.width, pictureTakenView.frame.size.height))
        imageView.image = origImage
       
        self.croppedImageView.hidden = true
        self.pictureTakenView.hidden = false
        
        self.pictureTakenView.addSubview(imageView)
        
//       print("pictureTakenView subviews \(pictureTakenView.subviews)")
    }//eom
    
   
    //MARK:
    func cropImage()
    {
        //get top corner coordinate of crop frame
        let cropToBoundFrame:CGRect = CGRectMake(0, 0, 0, 0)
        let topEdgePosition:CGFloat = CGRectGetMidY(cropToBoundFrame)
        
        //crop image to selected bounds
        let croppedRect:CGRect = CGRectMake(0, topEdgePosition, 320, 200)
        let tmp:CGImageRef = CGImageCreateWithImageInRect(imageToCrop .CGImage, croppedRect)!
        let croppedImage:UIImage = UIImage(CGImage: tmp)
        
        //convert cropped omage into NSData object
        let croppedImageData:NSData = UIImageJPEGRepresentation(croppedImage, 0.7)!
        guard let imageData:NSData = UIImageJPEGRepresentation(imageToCrop, 0.7) else { return }
        
        
        //get number of bytes in NSData
        let imageToCropDataSize:NSInteger = imageData.length
        
        print("original size \(imageToCropDataSize) bytes")
        guard let imageToBeResize:UIImage = UIImage(data: croppedImageData) else { return }
        
        imageToResize = imageToBeResize
        
        //resizing Image
        let imageResizeModel:resizeImage = resizeImage()
        imageResizeModel.resizeImage(imageToResize, resizeWidth: 320, resizeHeight: 200)
        
        let resizedImageData:NSData = imageResizeModel.thumbnailImageData
    
        //updating image
        guard let resizedImage:UIImage = UIImage(data: resizedImageData) else { return }
        croppedImageView.image = resizedImage
        croppedImageView.hidden = false
        pictureTakenView.hidden = true
        
        let resizedImageDataSize:NSInteger = resizedImageData.length
        print("resized size \(resizedImageDataSize) bytes")
        
    }//eom
    
    
    @IBAction func cropImage(sender: AnyObject)
    {
        self.cropImage()
    }//eom
    
    
}

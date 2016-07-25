//
//  TakePictureWithCustomOverlayViewController.swift
//  cameraApp
//
//  Created by Luis Castillo on 2/21/16.
//  Copyright © 2016 devbros. All rights reserved.
//

import UIKit

class TakePictureWithCustomOverlayViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    @IBOutlet weak var cameraView: UIView!
    //
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var takePictureButton: UIButton!
    
    
    var cameraPicker:UIImagePickerController = UIImagePickerController()

    
    //MARK: View Loading
    override func viewDidLoad() {
        super.viewDidLoad()

    }//eom

    override func viewDidAppear(animated: Bool) {
        
    }//eom
    
    
    //MARK:
    func setupAndTakePicture()
    {
        //device has camera
        if UIImagePickerController .isSourceTypeAvailable(.Camera)
        {
            cameraPicker                        = UIImagePickerController()
            cameraPicker.delegate               = self
            cameraPicker.sourceType             = UIImagePickerControllerSourceType.Camera
            cameraPicker.showsCameraControls    = false
            cameraPicker.cameraDevice           = UIImagePickerControllerCameraDevice.Front
            
            //remove elements from picture/video View
            for currView in cameraView.subviews
            {
                currView.removeFromSuperview()
            }

            cameraPicker.view.frame = self.cameraView.bounds
            
            self.cameraView.addSubview(self.cameraPicker.view)

            print("cameraPicker \(cameraPicker.view.debugDescription)")
            print("pictureTakenView \(cameraView.debugDescription)")

            cameraPicker.viewDidAppear(true)
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
        guard let origImage:UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        
        ////        print("\norigImage: \(origImage.debugDescription)")
        ////        print("\ncameraPicker: \(cameraPicker.view.debugDescription)")
        ////        print("\npictureTakenView: \(self.pictureTakenView.debugDescription)")
        ////        print("\nmainScreen: \(UIScreen.mainScreen().debugDescription)")
        //
        //        //remove elements from picture/video View
        //        for currView in self.pictureTakenView.subviews
        //        {
        //            currView.removeFromSuperview()
        //        }
        //
        //        let imageView:UIImageView = UIImageView(frame: CGRectMake(pictureTakenView.frame.origin.x, pictureTakenView.frame.origin.y, pictureTakenView.frame.size.width, pictureTakenView.frame.size.height))
        //        imageView.image = origImage

        
//        
//        self.pictureTakenView.addSubview(imageView)
//        
//        //       print("pictureTakenView subviews \(pictureTakenView.subviews)")
    }//eom
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        
    }//eom
    
    
    //MARK:
    func cropImage()
    {
//        //get top corner coordinate of crop frame
//        let cropToBoundFrame:CGRect = CGRectMake(0, 0, 0, 0)
//        let topEdgePosition:CGFloat = CGRectGetMidY(cropToBoundFrame)
//        
//        //crop image to selected bounds
//        let croppedRect:CGRect = CGRectMake(0, topEdgePosition, 320, 200)
//        let tmp:CGImageRef = CGImageCreateWithImageInRect(imageToCrop .CGImage, croppedRect)!
//        let croppedImage:UIImage = UIImage(CGImage: tmp)
//        
//        //convert cropped omage into NSData object
//        let croppedImageData:NSData = UIImageJPEGRepresentation(croppedImage, 0.7)!
//        guard let imageData:NSData = UIImageJPEGRepresentation(imageToCrop, 0.7) else { return }
//        
//        
//        //get number of bytes in NSData
//        let imageToCropDataSize:NSInteger = imageData.length
//        
//        print("original size \(imageToCropDataSize) bytes")
//        guard let imageToBeResize:UIImage = UIImage(data: croppedImageData) else { return }
//        
//        imageToResize = imageToBeResize
//        
//        //resizing Image
//        let imageResizeModel:resizeImage = resizeImage()
//        imageResizeModel.resizeImage(imageToResize, resizeWidth: 320, resizeHeight: 200)
//        
//        let resizedImageData:NSData = imageResizeModel.thumbnailImageData
//        
//        //updating image
//        guard let resizedImage:UIImage = UIImage(data: resizedImageData) else { return }
//        croppedImageView.image = resizedImage
//        croppedImageView.hidden = false
//        pictureTakenView.hidden = true
//        
//        let resizedImageDataSize:NSInteger = resizedImageData.length
//        print("resized size \(resizedImageDataSize) bytes")
//        
    }//eom
    
    
//    @IBAction func cropImage(sender: AnyObject)
//    {
//        self.cropImage()
//    }//eom
    
    //MARK: Take Picture
    @IBAction func takePicture(sender: AnyObject)
    {
        self.cameraPicker.takePicture()
    }//eo-a
    
    
    //MARK: Cancel
    @IBAction func cancel(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }//eo-a
    
    //MARK: Memory
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }//eom
    

    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
    }//eom
    

}//eoc

//
//  AllMediaViewController.swift
//  avFoundationExample
//
//  Created by Luis Castillo on 2/11/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class AllMediaViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    //options
    var optionSelected:Int = 0
    
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    //
    @IBOutlet weak var takePictureOrVideoButton: UIButton!
    
    @IBOutlet weak var pictureTakenView: UIView!
    @IBOutlet weak var baseOptionView: UIView!
    
    //video recording part 1
    @IBOutlet weak var confirmVideoButton: UIButton!
    @IBOutlet weak var remainingRecordingTimeLabel: UILabel!
    //
    var recordTimeRemaining:Int = 15
    
    //Confirm Media
    @IBOutlet weak var retakeMediaButton: UIButton!
    @IBOutlet weak var confirmMediaButton: UIButton!
    
    var libraryPicker:UIImagePickerController   = UIImagePickerController()
    var cameraPicker:UIImagePickerController    = UIImagePickerController()
    var videoPicker:UIImagePickerController     = UIImagePickerController()
    
    
    // MARK: - View Loading
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
         self.setupButton()
    }//eom
    
    
    // MARK: - Media Selection
    @IBAction func mediaOptionChanged(sender: UIButton)
    {
        //gallery
        if sender == self.galleryButton
        {
            self.galleryButton.selected = true
            self.cameraButton.selected  = false
            self.videoButton.selected   = false
            //
            self.updateButtonSelection()
            self.setupAndShowGallery()
        }
        //picture
        else if sender == self.cameraButton
        {
            self.galleryButton.selected = false
            self.cameraButton.selected  = true
            self.videoButton.selected   = false
            //
            self.updateButtonSelection()
            self.setupAndTakePicture()
        }
        //video
        else if sender == self.videoButton
        {
            self.galleryButton.selected = false
            self.cameraButton.selected  = false
            self.videoButton.selected   = true
            //
            self.updateButtonSelection()
            self.setupAndTakeVideo()
        }
    }//eo-a
    
    // MARK: Update Button Selection
    func updateButtonSelection()
    {
        if self.galleryButton.selected
        {
            self.galleryButton.setImageTintColor(UIColor.blueColor(), forState: UIControlState.Normal)
            self.cameraButton.setImageTintColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
            self.videoButton.setImageTintColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        }
        else if self.cameraButton.selected
        {
            self.galleryButton.setImageTintColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
            self.cameraButton.setImageTintColor(UIColor.blueColor(), forState: UIControlState.Normal)
            self.videoButton.setImageTintColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
            //
            self.retakeMediaButton.hidden           = true
            self.confirmMediaButton.hidden          = true
            self.confirmVideoButton.hidden          = true
            self.remainingRecordingTimeLabel.hidden = true
            //
            self.takePictureOrVideoButton.hidden    = false
        }
        else if self.videoButton.selected
        {
            self.galleryButton.setImageTintColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
            self.cameraButton.setImageTintColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
            self.videoButton.setImageTintColor(UIColor.blueColor(), forState: UIControlState.Normal)
            //
            self.retakeMediaButton.hidden           = true
            self.confirmMediaButton.hidden          = true
            //
            self.takePictureOrVideoButton.hidden    = false
            self.confirmVideoButton.hidden          = false
            self.remainingRecordingTimeLabel.hidden = false
        }
    }//eom
    
    func setupButton()
    {
        self.galleryButton.setImageTintColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        self.cameraButton.setImageTintColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        self.videoButton.setImageTintColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        
        if self.optionSelected == 1
        {
            self.galleryButton.selected = true
            self.cameraButton.selected  = false
            self.videoButton.selected   = false
            //
            self.setupAndShowGallery()
        }
        else if self.optionSelected == 2
        {
            self.galleryButton.selected = false
            self.cameraButton.selected  = true
            self.videoButton.selected   = false
            //
            self.setupAndTakePicture()
        }
        else if self.optionSelected == 3
        {
            self.galleryButton.selected = false
            self.cameraButton.selected  = false
            self.videoButton.selected   = true
            //
            self.setupAndTakeVideo()
        }
        
        self.updateButtonSelection()
    }//eom
    
    //MARK: Confirm Media
    func showConfirmMedia()
    {
        if self.cameraButton.selected
        {
            self.takePictureOrVideoButton.hidden = true
            
            self.retakeMediaButton.hidden   = false
            self.confirmMediaButton.hidden  = false
        }
        else if self.videoButton.selected
        {
            self.takePictureOrVideoButton.hidden    = true
            self.confirmVideoButton.hidden          = true
            self.remainingRecordingTimeLabel.hidden = true
            
            self.retakeMediaButton.hidden   = false
            self.confirmMediaButton.hidden  = false
        }
    }//eom
    
    @IBAction func confirmMedia(sender: UIButton)
    {
        if self.cameraButton.selected
        {
            
        }
        else if self.videoButton.selected
        {
            
        }
    }//eo-a
    
    @IBAction func retakeMedia(sender: UIButton)
    {
        if self.cameraButton.selected
        {
            
        }
        else if self.videoButton.selected
        {
            
        }
    }//eo-a
    
    // MARK: - [1] Gallery
    func setupAndShowGallery()
    {
        libraryPicker               = UIImagePickerController()
        libraryPicker.delegate      = self
        libraryPicker.sourceType    = UIImagePickerControllerSourceType.PhotoLibrary
        libraryPicker.allowsEditing = true
        
        self.presentViewController(libraryPicker, animated: true, completion: nil)
    }//eom
    
    //MARK: - [2] Picture
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
            for currView in pictureTakenView.subviews
            {
                currView.removeFromSuperview()
            }
            
            cameraPicker.view.frame             = self.pictureTakenView.bounds
            self.pictureTakenView.addSubview(self.cameraPicker.view)
            
            cameraPicker.viewDidAppear(true)
        }
        else
        {
          print("no camera avaliable")
        }
    }//eom
    
    @IBAction func takePictureOrVideo(sender: AnyObject)
    {
        if self.cameraButton.selected
        {
            cameraPicker.takePicture()
        }
        else if self.videoButton.selected
        {
            
        }
        
    }//eo-a
    
    
    //MARK: - [3] Video
    func setupAndTakeVideo()
    {
        //device has camera
        if UIImagePickerController .isSourceTypeAvailable(.Camera)
        {
            /* Image picker setup */
            videoPicker.delegate            = self
            videoPicker.sourceType          = UIImagePickerControllerSourceType.Camera
            //
            videoPicker.mediaTypes          = ["public.movie"]
            videoPicker.cameraCaptureMode   = UIImagePickerControllerCameraCaptureMode.Video
            //
            videoPicker.allowsEditing       = false
            videoPicker.showsCameraControls = false
            //
            videoPicker.cameraViewTransform = CGAffineTransformIdentity
            
            /* device has two cameras? */
            //rear camera
            if UIImagePickerController .isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Rear)
            {
                videoPicker.cameraDevice = UIImagePickerControllerCameraDevice.Rear
                
                //front camera
                if UIImagePickerController .isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Front)
                {
                    //cameraSelectionButton.alpha = 1.0;
                    //showCameraSelection = true
                }
            }
            //front camera
            else if UIImagePickerController .isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Front)
            {
                videoPicker.cameraDevice = UIImagePickerControllerCameraDevice.Front
            }
            
            /* device has flash? */
            if UIImagePickerController .isFlashAvailableForCameraDevice(videoPicker.cameraDevice)
            {
                videoPicker.cameraFlashMode = UIImagePickerControllerCameraFlashMode.Auto
                // flashModeButton.alpha = 1.0;
                // showFlashSelection = true
            }
            
            
            //video quality
            //imagePicker.videoQuality = UIImagePickerControllerQualityType.Type640x480
            
            //video duration
            //videoPicker.videoMaximumDuration = recordLimit
            
            
            
            //remove elements from picture/video View
            for currView in pictureTakenView.subviews
            {
                currView.removeFromSuperview()
            }
            
            videoPicker.view.frame  = self.pictureTakenView.bounds
            self.pictureTakenView.addSubview(self.videoPicker.view)
            
            videoPicker.viewDidAppear(true)
        }
        else
        {
            print("no camera avaliable")
        }
    }//eom
    
    
    @IBAction func mergeAndDisplayVideo(sender: AnyObject)
    {
        self.MergeVideos()
    }//eo
    
    func MergeVideos()
    {
        
        
    }//eom
    
    //MARK: - Image Picker Delegates
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        //gallery
        if self.galleryButton.selected
        {
            self.dismissViewControllerAnimated(true, completion: nil)
            
            var imageTake:UIImage?
            
            //image edit
            if let editImage = info[UIImagePickerControllerEditedImage] as? UIImage
            {
                imageTake = editImage
            }
            //original image
            else if let origImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            {
                imageTake = origImage
            }
            
            let totalVC:Int = (self.navigationController?.childViewControllers.count)!
            
            let childVCs = self.navigationController?.childViewControllers
            let vc = childVCs![totalVC-2] as? All_in_OneViewController
            
            vc?.imageChoosen.image = imageTake
            
            self.navigationController?.navigationBarHidden = false
            self.navigationController?.popViewControllerAnimated(true)
        }
        //camera
        else if self.cameraButton.selected
        {
            guard let origImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
            
            print("\norigImage: \(origImage.debugDescription)")
            print("\ncameraPicker: \(cameraPicker.view.debugDescription)")
            print("\npictureTakenView: \(pictureTakenView.debugDescription)")
            print("\nmainScreen: \(UIScreen.mainScreen().debugDescription)")
            
            let desiredSize:CGSize = CGSizeMake(pictureTakenView.frame.width, pictureTakenView.frame.height)
            let finalImage:UIImage = origImage.imageByScalingAndCroppingForSizeWithCenter(desiredSize)
            
            print("\ndesiredSize: \(desiredSize)")
            
            print("\nfinalImage: \(finalImage)")
            
//            let mainScreen = UIScreen.mainScreen()
//            let screenFrame:CGSize  = CGSizeMake(mainScreen.bounds.width, mainScreen.bounds.height)
//            
////             let screenFrame:CGSize  = CGSizeMake(cameraPicker.view.frame.width
////                , cameraPicker.view.frame.width)
//            
////            let rectFrame:CGRect    = CGRectMake(0, 0, pictureTakenView.frame.width, pictureTakenView.frame.width)
//            
//            let rectFrame:CGRect = CGRectMake(0, 0, cameraPicker.view.frame.width, cameraPicker.view.frame.width)
//            
//            let cropRect:CGRect = CGRectMake(0, 0, pictureTakenView.frame.width, pictureTakenView.frame.width)
//            
//            print("\norigImage: \(origImage.debugDescription)")
//            print("\ncameraPicker: \(cameraPicker.view.debugDescription)")
//            print("\npictureTakenView: \(pictureTakenView.debugDescription)")
//            print("\nmainScreen: \(mainScreen.debugDescription)")
//            print("\nscreenFrame: \(screenFrame)")
//            print("\nrectFrame: \(rectFrame)")
//            print("\ncropRect: \(cropRect)")
//            
//            UIGraphicsBeginImageContext(screenFrame)
//            origImage.drawInRect(rectFrame)
//            let modImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            
//            let imageRef:CGImageRef? = CGImageCreateWithImageInRect(modImage.CGImage, cropRect)
//            let finalImage:UIImage = UIImage(CGImage: imageRef!)
//            
            
            
            
            
            //remove elements from picture/video View
            for currView in pictureTakenView.subviews
            {
                currView.removeFromSuperview()
            }
            
            let imageView:UIImageView = UIImageView(image: finalImage)
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            self.pictureTakenView.addSubview(imageView)
            self.showConfirmMedia()
        }
        //video
        else if self.videoButton.selected
        {
            
        }
    }//eom
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if self.galleryButton.selected
        {
            self.dismissViewControllerAnimated(true, completion: nil)
            self.navigationController?.popViewControllerAnimated(false)
        }
        else if self.cameraButton.selected
        {
            self.setupAndTakePicture()
        }
        else if self.videoButton.selected
        {
            self.setupAndTakeVideo()
        }
    }//eom
    
    
        
    // MARK: - Memory
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//eom
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
    }//eom

}

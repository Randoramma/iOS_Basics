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
    @IBAction func mediaOptionChanged(_ sender: UIButton)
    {
        //gallery
        if sender == self.galleryButton
        {
            self.galleryButton.isSelected = true
            self.cameraButton.isSelected  = false
            self.videoButton.isSelected   = false
            //
            self.updateButtonSelection()
            self.setupAndShowGallery()
        }
        //picture
        else if sender == self.cameraButton
        {
            self.galleryButton.isSelected = false
            self.cameraButton.isSelected  = true
            self.videoButton.isSelected   = false
            //
            self.updateButtonSelection()
            self.setupAndTakePicture()
        }
        //video
        else if sender == self.videoButton
        {
            self.galleryButton.isSelected = false
            self.cameraButton.isSelected  = false
            self.videoButton.isSelected   = true
            //
            self.updateButtonSelection()
            self.setupAndTakeVideo()
        }
    }//eo-a
    
    // MARK: Update Button Selection
    func updateButtonSelection()
    {
        if self.galleryButton.isSelected
        {
            self.galleryButton.setImageTintColor(UIColor.blue, forState: UIControlState())
            self.cameraButton.setImageTintColor(UIColor.lightGray, forState: UIControlState())
            self.videoButton.setImageTintColor(UIColor.lightGray, forState: UIControlState())
        }
        else if self.cameraButton.isSelected
        {
            self.galleryButton.setImageTintColor(UIColor.lightGray, forState: UIControlState())
            self.cameraButton.setImageTintColor(UIColor.blue, forState: UIControlState())
            self.videoButton.setImageTintColor(UIColor.lightGray, forState: UIControlState())
            //
            self.retakeMediaButton.isHidden           = true
            self.confirmMediaButton.isHidden          = true
            self.confirmVideoButton.isHidden          = true
            self.remainingRecordingTimeLabel.isHidden = true
            //
            self.takePictureOrVideoButton.isHidden    = false
        }
        else if self.videoButton.isSelected
        {
            self.galleryButton.setImageTintColor(UIColor.lightGray, forState: UIControlState())
            self.cameraButton.setImageTintColor(UIColor.lightGray, forState: UIControlState())
            self.videoButton.setImageTintColor(UIColor.blue, forState: UIControlState())
            //
            self.retakeMediaButton.isHidden           = true
            self.confirmMediaButton.isHidden          = true
            //
            self.takePictureOrVideoButton.isHidden    = false
            self.confirmVideoButton.isHidden          = false
            self.remainingRecordingTimeLabel.isHidden = false
        }
    }//eom
    
    func setupButton()
    {
        self.galleryButton.setImageTintColor(UIColor.lightGray, forState: UIControlState())
        self.cameraButton.setImageTintColor(UIColor.lightGray, forState: UIControlState())
        self.videoButton.setImageTintColor(UIColor.lightGray, forState: UIControlState())
        
        if self.optionSelected == 1
        {
            self.galleryButton.isSelected = true
            self.cameraButton.isSelected  = false
            self.videoButton.isSelected   = false
            //
            self.setupAndShowGallery()
        }
        else if self.optionSelected == 2
        {
            self.galleryButton.isSelected = false
            self.cameraButton.isSelected  = true
            self.videoButton.isSelected   = false
            //
            self.setupAndTakePicture()
        }
        else if self.optionSelected == 3
        {
            self.galleryButton.isSelected = false
            self.cameraButton.isSelected  = false
            self.videoButton.isSelected   = true
            //
            self.setupAndTakeVideo()
        }
        
        self.updateButtonSelection()
    }//eom
    
    //MARK: Confirm Media
    func showConfirmMedia()
    {
        if self.cameraButton.isSelected
        {
            self.takePictureOrVideoButton.isHidden = true
            
            self.retakeMediaButton.isHidden   = false
            self.confirmMediaButton.isHidden  = false
        }
        else if self.videoButton.isSelected
        {
            self.takePictureOrVideoButton.isHidden    = true
            self.confirmVideoButton.isHidden          = true
            self.remainingRecordingTimeLabel.isHidden = true
            
            self.retakeMediaButton.isHidden   = false
            self.confirmMediaButton.isHidden  = false
        }
    }//eom
    
    @IBAction func confirmMedia(_ sender: UIButton)
    {
        if self.cameraButton.isSelected
        {
            
        }
        else if self.videoButton.isSelected
        {
            
        }
    }//eo-a
    
    @IBAction func retakeMedia(_ sender: UIButton)
    {
        if self.cameraButton.isSelected
        {
            
        }
        else if self.videoButton.isSelected
        {
            
        }
    }//eo-a
    
    // MARK: - [1] Gallery
    func setupAndShowGallery()
    {
        libraryPicker               = UIImagePickerController()
        libraryPicker.delegate      = self
        libraryPicker.sourceType    = UIImagePickerControllerSourceType.photoLibrary
        libraryPicker.allowsEditing = true
        
        self.present(libraryPicker, animated: true, completion: nil)
    }//eom
    
    //MARK: - [2] Picture
    func setupAndTakePicture()
    {
        //device has camera
        if UIImagePickerController .isSourceTypeAvailable(.camera)
        {
            cameraPicker                        = UIImagePickerController()
            cameraPicker.delegate               = self
            cameraPicker.sourceType             = UIImagePickerControllerSourceType.camera
            cameraPicker.showsCameraControls    = false
            cameraPicker.cameraDevice           = UIImagePickerControllerCameraDevice.front
            
            
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
    
    @IBAction func takePictureOrVideo(_ sender: AnyObject)
    {
        if self.cameraButton.isSelected
        {
            cameraPicker.takePicture()
        }
        else if self.videoButton.isSelected
        {
            
        }
        
    }//eo-a
    
    
    //MARK: - [3] Video
    func setupAndTakeVideo()
    {
        //device has camera
        if UIImagePickerController .isSourceTypeAvailable(.camera)
        {
            /* Image picker setup */
            videoPicker.delegate            = self
            videoPicker.sourceType          = UIImagePickerControllerSourceType.camera
            //
            videoPicker.mediaTypes          = ["public.movie"]
            videoPicker.cameraCaptureMode   = UIImagePickerControllerCameraCaptureMode.video
            //
            videoPicker.allowsEditing       = false
            videoPicker.showsCameraControls = false
            //
            videoPicker.cameraViewTransform = CGAffineTransform.identity
            
            /* device has two cameras? */
            //rear camera
            if UIImagePickerController .isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.rear)
            {
                videoPicker.cameraDevice = UIImagePickerControllerCameraDevice.rear
                
                //front camera
                if UIImagePickerController .isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.front)
                {
                    //cameraSelectionButton.alpha = 1.0;
                    //showCameraSelection = true
                }
            }
            //front camera
            else if UIImagePickerController .isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.front)
            {
                videoPicker.cameraDevice = UIImagePickerControllerCameraDevice.front
            }
            
            /* device has flash? */
            if UIImagePickerController .isFlashAvailable(for: videoPicker.cameraDevice)
            {
                videoPicker.cameraFlashMode = UIImagePickerControllerCameraFlashMode.auto
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
    
    
    @IBAction func mergeAndDisplayVideo(_ sender: AnyObject)
    {
        self.MergeVideos()
    }//eo
    
    func MergeVideos()
    {
        
        
    }//eom
    
    //MARK: - Image Picker Delegates
    func imagePickerController(_ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : Any])
    {
        //gallery
        if self.galleryButton.isSelected
        {
            self.dismiss(animated: true, completion: nil)
            
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
            
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.popViewController(animated: true)
        }
        //camera
        else if self.cameraButton.isSelected
        {
            guard let origImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
            
            print("\norigImage: \(origImage.debugDescription)")
            print("\ncameraPicker: \(cameraPicker.view.debugDescription)")
            print("\npictureTakenView: \(pictureTakenView.debugDescription)")
            print("\nmainScreen: \(UIScreen.main.debugDescription)")
            
            let desiredSize:CGSize = CGSize(width: pictureTakenView.frame.width, height: pictureTakenView.frame.height)
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
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            self.pictureTakenView.addSubview(imageView)
            self.showConfirmMedia()
        }
        //video
        else if self.videoButton.isSelected
        {
            
        }
    }//eom
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        self.dismiss(animated: true, completion: nil)
        
        if self.galleryButton.isSelected
        {
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: false)
        }
        else if self.cameraButton.isSelected
        {
            self.setupAndTakePicture()
        }
        else if self.videoButton.isSelected
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
    }//eom

}

//
//  VideoMakerViewController.swift
//  VideoRecording
//
//  Created by Luis Castillo on 1/15/16.
//  Copyright © 2016 T2. All rights reserved.
//

import UIKit

class VideoMakerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    @IBOutlet var cameraOverLayView: UIView!
    
    @IBOutlet weak var startStopRecordingButton: UIButton!
    
    @IBOutlet var recordingGesture: UILongPressGestureRecognizer!
    
    @IBOutlet weak var saveVideoButton: UIButton!
    
    @IBOutlet weak var recordingTimeLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    
    var videosRecorded:NSMutableArray = NSMutableArray()
    
    //properties
    let imagePicker = UIImagePickerController()
    
    var showCameraSelection:Bool    = false
    var showFlashSelection:Bool     = false
    
    var timer:NSTimer?
    let timerSelector:Selector = Selector.init("updateTimeRecording")
    var recordedTime:Int = 0
    
    var wantsToLeaveVideoRecording:Bool = false
    
    //MARK: - View Loading
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.setupImagePicker()
    }//eom
    
    override func viewWillAppear(animated: Bool)
    {
        
        if wantsToLeaveVideoRecording
        {
            //leaving camera controller
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else
        {
            //setting overlay frame
            let frameSize = imagePicker.view .frame
            cameraOverLayView.frame = frameSize
            
            //presenting imagePicker
            self.presentViewController(imagePicker, animated: true) { () -> Void in
                
            }
            
            //adding overlay to imagepicker
            imagePicker.cameraOverlayView = cameraOverLayView
        }
        
    }//eom
    
    
    //MARK: - Image Picker
    func setupImagePicker()
    {
        let cameraAvaliable:Bool        =   UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        let deviceHasFrontCamera:Bool   =   UIImagePickerController .isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Front)
        let deviceHasRearCamera:Bool    =   UIImagePickerController .isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Rear)
       
        /* checking device has a camera */
        if (cameraAvaliable == false)
        {
            self.dismissViewControllerAnimated(true, completion: nil)
        }//
        
        
        /* Image picker setup */
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        //
        imagePicker.mediaTypes = ["public.movie"]
        imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.Video
        //
        imagePicker.allowsEditing = false
        imagePicker.showsCameraControls = false
        //
        imagePicker.cameraViewTransform = CGAffineTransformIdentity
        
        
        
        /* device has two cameras? */
        
        //rear camera
        if deviceHasRearCamera
        {
            imagePicker.cameraDevice = UIImagePickerControllerCameraDevice.Rear
            
            //front camera
            if deviceHasFrontCamera
            {
                //cameraSelectionButton.alpha = 1.0;
                showCameraSelection = true
            }
        }
        //front camera
        else
        {
            imagePicker.cameraDevice = UIImagePickerControllerCameraDevice.Front
        }
        
        /* device has flash? */
        if UIImagePickerController .isFlashAvailableForCameraDevice(imagePicker.cameraDevice)
        {
            imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashMode.Auto
            // flashModeButton.alpha = 1.0;
            showFlashSelection = true
        }
        
        //video quality
        imagePicker.videoQuality = UIImagePickerControllerQualityType.Type640x480
        
        //video duration
        imagePicker.videoMaximumDuration = NSTimeInterval.init(10)
        
    }//eom
    
    //video picked
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        //video info
        if let videoInfo:NSDictionary = info
        {
            print("videoInfo: \(videoInfo.debugDescription)\n")
            
            //saving video locally
            if let videoURL:NSURL =  videoInfo .objectForKey(UIImagePickerControllerMediaURL) as? NSURL
            {
                print("videoURL: \(videoURL.debugDescription)\n")
                if let pathToVideo:String = videoURL .path
                {
                    print("pathToVideo: \(pathToVideo.debugDescription)\n")
                    
                    //saving videos url
                    self.videosRecorded.addObject(pathToVideo)
                }//eo-video path
            }//eo-video url
            else
            {
                print("no data recorded!!\n")
            }
        }//eo-video info
        else
        {
            print("no information on video recorded, some bad happen?!!\n")
        }

    }//eom
    
    func saveVideoLocally()
    {
        if videosRecorded.count > 0
        {
            //getting video
            guard let pathToVideo = videosRecorded.firstObject as? String else { return }
            
            //verify video is okay to save locally
            let okToSaveVideoLocally:Bool = UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(pathToVideo)
            if okToSaveVideoLocally
            {
                print("saving video locally")
                
                UISaveVideoAtPathToSavedPhotosAlbum(pathToVideo, self, Selector("video:error:contextInfo:"), nil)
            }
            else
            {
                
                print("un-able to save video locally")
                let errorVar:NSError = NSError(domain: "someUnkErro", code: 123, userInfo: nil)
                let voidContext:UnsafeMutablePointer<Void> = UnsafeMutablePointer<Void>()
                self .video(pathToVideo, error: errorVar, contextInfo: voidContext)
            }
        }
    }//eom
    
    //after video is saved
    func video(videoPath:String ,  error:NSError , contextInfo:UnsafeMutablePointer<Void> )
    {
        //showing main controls
        UIView .animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations:
            { () -> Void in
                //things to animate
                
                self.recordedTime = 0
                self.recordingTimeLabel.text = " "
                self.saveVideoButton.hidden = true
                
                
//                //
//                if self.showCameraSelection
//                {
//                    //cameraSelectionButton.alpha = 1.0;
//                }
//                
//                //
//                if self.showFlashSelection
//                {
//                    //flashModeButton.alpha = 1.0;
//                }
//                
//                videoQualitySelectionButton.alpha = 1.0;
//                
//                recordIndicatorView.alpha = 0.0
                
            }) { (Bool) -> Void in
            //animation completed
        }//
    }//eom
    
    
     //MARK: - Video Recording
    @IBAction func recording(sender: UILongPressGestureRecognizer)
    {
        switch(recordingGesture.state)
        {
            case UIGestureRecognizerState.Began:
                print("recording began\n")
                self.imagePicker .startVideoCapture()
                self.startTimer()
                break
            case UIGestureRecognizerState.Ended:
                print("recording ended, stopping video\n")
                self.imagePicker .stopVideoCapture()
                self.stopTimer()
                break
            case UIGestureRecognizerState.Cancelled:
                print("recording cancel, stopping video\n")
                self.imagePicker .stopVideoCapture()
                self.stopTimer()
                break
            case UIGestureRecognizerState.Failed:
                print("recording Failed, stopping video\n")
                self.imagePicker .stopVideoCapture()
                self.stopTimer()
                break
            case UIGestureRecognizerState.Changed:
                //print("still recording, NO Action")
                break
            default:
                print("recording STOPPED, unk reason\n")
                self.imagePicker .stopVideoCapture()
                self.stopTimer()
                break
        }
    }//eo-a
    
    //MARK: Timer
    func startTimer()
    {
        self.cancelButton.hidden    = true
        self.saveVideoButton.hidden = true
        self.recordingTimeLabel.text = "\(recordedTime)"
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: timerSelector, userInfo: nil, repeats: true)
    }//eom
    
    func stopTimer()
    {
        self.cancelButton.hidden = false
        self.recordedTime = 0
        self.timer?.invalidate()
    }//eom
    
    func updateTimeRecording()
    {
        self.recordedTime++
        self.recordingTimeLabel.text = "\(recordedTime)"
        self.saveVideoButton.hidden = false
    }//eom
   
    
    //MARK: - Save Video
    @IBAction func saveVideo(sender: AnyObject)
    {
        print("videosRecorded: \(videosRecorded.debugDescription)")
        self.saveVideoLocally()
    }//eo-a
    
    
    //MARK: - Cancel
    @IBAction func cancel(sender: AnyObject)
    {
        self.wantsToLeaveVideoRecording = true
        self.dismissViewControllerAnimated(true, completion: nil)
    }//eo-a
    
    //MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//eom
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        
    }//eom

}

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
    
    var timer:Timer?
    let timerSelector:Selector = #selector(VideoMakerViewController.updateTimeRecording)
    var recordedTime:Int = 0
    
    var wantsToLeaveVideoRecording:Bool = false
    
    //MARK: - View Loading
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.setupImagePicker()
    }//eom
    
    override func viewWillAppear(_ animated: Bool)
    {
        
        if wantsToLeaveVideoRecording
        {
            //leaving camera controller
            self.dismiss(animated: true, completion: nil)
        }
        else
        {
            //setting overlay frame
            let frameSize = imagePicker.view .frame
            cameraOverLayView.frame = frameSize
            
            //presenting imagePicker
            self.present(imagePicker, animated: true) { () -> Void in
                
            }
            
            //adding overlay to imagepicker
            imagePicker.cameraOverlayView = cameraOverLayView
        }
        
    }//eom
    
    
    //MARK: - Image Picker
    func setupImagePicker()
    {
        let cameraAvaliable:Bool        =   UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        let deviceHasFrontCamera:Bool   =   UIImagePickerController .isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.front)
        let deviceHasRearCamera:Bool    =   UIImagePickerController .isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.rear)
       
        /* checking device has a camera */
        if (cameraAvaliable == false)
        {
            self.dismiss(animated: true, completion: nil)
        }//
        
        
        /* Image picker setup */
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        //
        imagePicker.mediaTypes = ["public.movie"]
        imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.video
        //
        imagePicker.allowsEditing = false
        imagePicker.showsCameraControls = false
        //
        imagePicker.cameraViewTransform = CGAffineTransform.identity
        
        
        
        /* device has two cameras? */
        
        //rear camera
        if deviceHasRearCamera
        {
            imagePicker.cameraDevice = UIImagePickerControllerCameraDevice.rear
            
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
            imagePicker.cameraDevice = UIImagePickerControllerCameraDevice.front
        }
        
        /* device has flash? */
        if UIImagePickerController .isFlashAvailable(for: imagePicker.cameraDevice)
        {
            imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashMode.auto
            // flashModeButton.alpha = 1.0;
            showFlashSelection = true
        }
        
        //video quality
        imagePicker.videoQuality = UIImagePickerControllerQualityType.type640x480
        
        //video duration
        imagePicker.videoMaximumDuration = TimeInterval.init(10)
        
    }//eom
    
    //video picked
    func imagePickerController(_ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : Any])
    {
        //video info
        if let videoInfo:NSDictionary = info as NSDictionary?
        {
            print("videoInfo: \(videoInfo.debugDescription)\n")
            
            //saving video locally
            if let videoURL:URL =  videoInfo .object(forKey: UIImagePickerControllerMediaURL) as? URL
            {
                print("videoURL: \(videoURL.debugDescription)\n")
        
                //saving videos url
                self.videosRecorded.add(videoURL.path)
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
                
                UISaveVideoAtPathToSavedPhotosAlbum(pathToVideo, self, #selector(VideoMakerViewController.video(_:error:contextInfo:)), nil)
            }
            else
            {
                
                print("un-able to save video locally")
                let errorVar:NSError = NSError(domain: "someUnkErro", code: 123, userInfo: nil)
                let voidContext:UnsafeMutableRawPointer? = nil
                self .video(pathToVideo, error: errorVar, contextInfo: voidContext!)
            }
        }
    }//eom
    
    //after video is saved
    func video(_ videoPath:String ,  error:NSError , contextInfo:UnsafeMutableRawPointer )
    {
        //showing main controls
        UIView .animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions(), animations:
            { () -> Void in
                //things to animate
                
                self.recordedTime = 0
                self.recordingTimeLabel.text = " "
                self.saveVideoButton.isHidden = true
                
                
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
    @IBAction func recording(_ sender: UILongPressGestureRecognizer)
    {
        switch(recordingGesture.state)
        {
            case UIGestureRecognizerState.began:
                print("recording began\n")
                self.imagePicker .startVideoCapture()
                self.startTimer()
                break
            case UIGestureRecognizerState.ended:
                print("recording ended, stopping video\n")
                self.imagePicker .stopVideoCapture()
                self.stopTimer()
                break
            case UIGestureRecognizerState.cancelled:
                print("recording cancel, stopping video\n")
                self.imagePicker .stopVideoCapture()
                self.stopTimer()
                break
            case UIGestureRecognizerState.failed:
                print("recording Failed, stopping video\n")
                self.imagePicker .stopVideoCapture()
                self.stopTimer()
                break
            case UIGestureRecognizerState.changed:
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
        self.cancelButton.isHidden    = true
        self.saveVideoButton.isHidden = true
        self.recordingTimeLabel.text = "\(recordedTime)"
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: timerSelector, userInfo: nil, repeats: true)
    }//eom
    
    func stopTimer()
    {
        self.cancelButton.isHidden = false
        self.recordedTime = 0
        self.timer?.invalidate()
    }//eom
    
    func updateTimeRecording()
    {
        self.recordedTime += 1
        self.recordingTimeLabel.text = "\(recordedTime)"
        self.saveVideoButton.isHidden = false
    }//eom
   
    
    //MARK: - Save Video
    @IBAction func saveVideo(_ sender: AnyObject)
    {
        print("videosRecorded: \(videosRecorded.debugDescription)")
        self.saveVideoLocally()
    }//eo-a
    
    
    //MARK: - Cancel
    @IBAction func cancel(_ sender: AnyObject)
    {
        self.wantsToLeaveVideoRecording = true
        self.dismiss(animated: true, completion: nil)
    }//eo-a
    
    //MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//eom
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        
    }//eom

}

//
//  imageCaptureViewController.swift
//  avFoundationExample
//
//  Created by Luis Castillo on 2/11/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit
import AVFoundation
import ImageIO

class imageCaptureViewController: UIViewController {

    
    let session:AVCaptureSession = AVCaptureSession()
    
    @IBOutlet weak var mainView: UIView!
    
    //take image properties
    @IBOutlet var takeImageView: UIView!
    @IBOutlet weak var vImagePreview: UIView!
    @IBOutlet weak var captureImageButton: UIButton!
    
    //review image
    @IBOutlet var reviewImageView: UIView!
    @IBOutlet weak var vImage: UIImageView!
    @IBOutlet weak var closeReviewImageButton: UIButton!
    
    
    var stillImageOutput:AVCaptureStillImageOutput = AVCaptureStillImageOutput()
    
    
    //MARK: View Loading
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }//eom

    override func viewDidAppear(_ animated: Bool)
    {
        self.updateMainViewBasedOnNavBar()
        self.changeViewToReviewImage(isShowingImage: false)
        self.setupCamera()
    }//eom
    
    
    //MARK: - Actions
    @IBAction func captureImage(_ sender: UIButton)
    {
        self.takeAndCaptureImage()
    }//eo-a
    
    @IBAction func closeReviewImage(_ sender: AnyObject)
    {
        self.changeViewToReviewImage(isShowingImage: false)
    }//eo-a
    
    //MARK: - Camera Setup
    func setupCamera()
    {
        
        //changing image quality
//        if  AVCaptureSession().canSetSessionPreset(AVCaptureSessionPresetMedium)
//        {
//            session.sessionPreset = AVCaptureSessionPresetMedium
//        }
        
        
        let captureVideoPreviewLayer:AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        
        captureVideoPreviewLayer.frame = self.takeImageView.bounds
        self.vImagePreview.layer.addSublayer(captureVideoPreviewLayer)
        
        let device:AVCaptureDevice =  AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do
        {
            let input:AVCaptureDeviceInput = try AVCaptureDeviceInput(device: device)
            
            session.addInput(input)
            
            stillImageOutput = AVCaptureStillImageOutput()
            let outputSettings:[AnyHashable: Any] = [AVVideoCodecJPEG : AVVideoCodecKey]
            
            stillImageOutput.outputSettings = outputSettings
            session.addOutput(stillImageOutput)
            session.startRunning()
        }
        catch
        {
            print("error trying to open camera")
        }
    }//eom
    
    
    //MARK: - Take Image
    func takeAndCaptureImage()
    {
        var videoConnection:AVCaptureConnection? = nil
        
        for currConnection in stillImageOutput.connections
        {
            guard let curr:AVCaptureConnection = currConnection as? AVCaptureConnection
                else { continue }
            
            for port in curr.inputPorts
            {
                guard let currPort = port as? AVCaptureInputPort else { continue }
                
                let portMedia = NSString(string: currPort.mediaType)
                if portMedia.isEqual(to: AVMediaTypeVideo)
                {
                    videoConnection = curr
                    break
                }
            }//eofl
            
            if videoConnection != nil
            {
                break
            }
        }//eofl
        
        
        stillImageOutput.captureStillImageAsynchronously(from: videoConnection)
        { (imageSampleBuffer:CMSampleBuffer?, error:Error?) in
            
            //                let exifAttachments:CFDictionaryRef = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, nil)
            //                if exifAttachments == true
            //                {
            //                    // Do something with the attachments.
            //                }
            //                else
            //                {
            //                    //no attachments
            //                }
            
            if let imageData:Data = AVCaptureStillImageOutput .jpegStillImageNSDataRepresentation(imageSampleBuffer)
            {
                if let image:UIImage = UIImage(data: imageData)
                {
                    //change view
                    self.changeViewToReviewImage(isShowingImage: true)
                    
                    self.vImage.image = image
                    
                    //saving image to device
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                }
            }
        }//eo
    }//eom
    
    
    //MARK: -  Helper Method
    func changeViewToReviewImage(isShowingImage:Bool)
    {
        //removing all views
        let mainSubViews:[UIView] = self.mainView.subviews
        for currSubViews:UIView in mainSubViews
        {
            currSubViews.removeFromSuperview()
        }//eofl
        
        if isShowingImage
        {
            /* display 'image' taken*/
            self.reviewImageView.frame = self.mainView.bounds
            self.reviewImageView.updateConstraintsIfNeeded()
            self.mainView.addSubview(self.reviewImageView)
        }
        else
        {
            /* display 'take image' */
            self.takeImageView.frame = self.mainView.bounds
            self.takeImageView.updateConstraintsIfNeeded()
            self.mainView.addSubview(self.takeImageView)
        }
    }//eom
    
    
    func updateMainViewBasedOnNavBar()
    {
        if let navbar_sizeHeight:CGFloat? = self.navigationController?.navigationBar.frame.size.height
        {
            let newHeight = navbar_sizeHeight! + 1
            
            self.mainView.frame = CGRect(x: self.mainView.frame.origin.x,
                                         y: newHeight,
                                         width: self.mainView.frame.size.width,
                                         height: self.mainView.frame.size.height)
        }
    }//eom
    
    func debug()
    {
        print("\n nav bar Origin (X|Y): \(self.navigationController?.navigationBar.frame.origin.x) | \(self.navigationController?.navigationBar.frame.origin.y)")
        print("\n nav bar Size Width: \(self.navigationController?.navigationBar.frame.size.width)")
        print("\n nav bar Size Height: \(self.navigationController?.navigationBar.frame.size.height)")
        
        
        let mainView_Frame = self.mainView.frame
        print("\nMain Image")
        print("x: \(mainView_Frame.origin.x)")
        print("y: \(mainView_Frame.origin.y)")
        print("width: \(mainView_Frame.size.width)")
        print("height: \(mainView_Frame.size.height)")
        
        let takeImageView_Frame = self.takeImageView.frame
        print("\nTake Image")
        print("x: \(takeImageView_Frame.origin.x)")
        print("y: \(takeImageView_Frame.origin.y)")
        print("width: \(takeImageView_Frame.size.width)")
        print("height: \(takeImageView_Frame.size.height)")
        
        let reviewImageView_Frame = self.reviewImageView.frame
        print("\nReview Image")
        print("x: \(reviewImageView_Frame.origin.x)")
        print("y: \(reviewImageView_Frame.origin.y)")
        print("width: \(reviewImageView_Frame.size.width)")
        print("height: \(reviewImageView_Frame.size.height)")
    }//eom
   
}

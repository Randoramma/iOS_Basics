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

    
    
    
    @IBOutlet weak var vImagePreview: UIView!
    @IBOutlet weak var vImage: UIImageView!
    @IBOutlet weak var captureImageButton: UIButton!
    
    
    var stillImageOutput:AVCaptureStillImageOutput = AVCaptureStillImageOutput()
    
    
    //MARK: View Loading
    override func viewDidLoad()
    {
        super.viewDidLoad()


        
    }//eom

    override func viewDidAppear(animated: Bool)
    {
        let session:AVCaptureSession = AVCaptureSession()
        session.sessionPreset = AVCaptureSessionPresetMedium
        
        
        let viewLayer = self.vImagePreview.layer
        
        print("\(viewLayer.debugDescription)")
        
        let captureVideoPreviewLayer:AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        
        captureVideoPreviewLayer.frame = self.vImagePreview.bounds
        self.vImagePreview.layer.addSublayer(captureVideoPreviewLayer)
        
        let device:AVCaptureDevice =  AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        do
        {
            let input:AVCaptureDeviceInput = try AVCaptureDeviceInput(device: device)
            
            session.addInput(input)
            
            stillImageOutput = AVCaptureStillImageOutput()
            let outputSettings:[NSObject: AnyObject] = [AVVideoCodecJPEG : AVVideoCodecKey]
            
            stillImageOutput.outputSettings = outputSettings
            session.addOutput(stillImageOutput)
            session.startRunning()
        }
        catch
        {
            print("error trying to open camera")
        }
    }//eom
    
    override func viewDidDisappear(animated: Bool)
    {
        
    }//eom
    
    
    
    //MARK: Take Image
    @IBAction func captureImage(sender: UIButton)
    {
        var videoConnection:AVCaptureConnection = AVCaptureConnection()
        for currConnection in stillImageOutput.connections
        {
            guard let curr = currConnection as? AVCaptureConnection else { continue }
        
            for port in curr.inputPorts
            {
                guard let currPort = port as? AVCaptureInputPort else { continue }
                
                let portMedia = NSString(string: currPort.mediaType)
                if portMedia.isEqualToString(AVMediaTypeVideo)
                {
                    videoConnection = curr
                    break
                }
            }//eofl
            
            if videoConnection == true
            {
                break
            }
        }//eofl

        print("about to request a capture from: \(stillImageOutput)")
        
        stillImageOutput.captureStillImageAsynchronouslyFromConnection(videoConnection)
            { (imageSampleBuffer:CMSampleBuffer!, error:NSError!) -> Void in
            
//                let exifAttachments:CFDictionaryRef = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, nil)
//                if exifAttachments == true
//                {
//                    // Do something with the attachments.
//                }
//                else
//                {
//                    //no attachments
//                }
                
                if let imageData:NSData = AVCaptureStillImageOutput .jpegStillImageNSDataRepresentation(imageSampleBuffer)
                {
                   if let image:UIImage = UIImage(data: imageData)
                   {
                        self.vImage.image = image
                        
                        //saving image to device
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                    }
                }
        }//eo
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

}

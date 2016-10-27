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

    override func viewDidAppear(_ animated: Bool)
    {
        let session:AVCaptureSession = AVCaptureSession()
        session.sessionPreset = AVCaptureSessionPresetMedium
        
        
        let viewLayer = self.vImagePreview.layer
        
        print("\(self) \(viewLayer.debugDescription)")
        
        let captureVideoPreviewLayer:AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        
        captureVideoPreviewLayer.frame = self.vImagePreview.bounds
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
    
    override func viewDidDisappear(_ animated: Bool)
    {
        
    }//eom
    
    
    
    //MARK: Take Image
    @IBAction func captureImage(_ sender: UIButton)
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

        print("about to request a capture from: \(stillImageOutput)")
        
        stillImageOutput.captureStillImageAsynchronously(from: videoConnection) { (imageSampleBuffer:CMSampleBuffer?, error:Error?) in
           
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
    
    }//eom

}

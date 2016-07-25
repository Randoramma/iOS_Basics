//
//  videoPlayMainViewController.swift
//  avFoundationExample
//
//  Created by Luis Castillo on 2/10/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

//needed for kUTTypeMovie identifier
import MobileCoreServices

/* needed for presenting Videos on device 
    UIImagePickerControllerDelegate
    UINavigationControllerDelegate
*/

class videoPlayMainViewController: UIViewController,
                                    UIImagePickerControllerDelegate,
                                    UINavigationControllerDelegate
{
    
    
    //MARK: - View Loading
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
    }//eom
    
    override func viewDidAppear(animated: Bool)
    {
        
    }//eom
    
    override func viewDidDisappear(animated: Bool)
    {
        
    }//eom
    
    
    
    // MARK:  - Choosing Video
    @IBAction func chooseVideoFromDevice(sender: AnyObject)
    {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .SavedPhotosAlbum
        imagePickerController.mediaTypes = [kUTTypeMovie as String]
        imagePickerController.delegate = self
        
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }//eo-a
   
    
    // MARK:  Image Picker Delegates
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if let videoPlayer = self.storyboard?.instantiateViewControllerWithIdentifier("VideoPlayer") as? VideoPlayerViewController
        {
            videoPlayer.videoURL = info[UIImagePickerControllerMediaURL] as? NSURL
            self.presentViewController(videoPlayer, animated: true, completion: nil)
        }
        else
        {
            print("un-able to start video player")
        }
        
    }//eom
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
    }//eom
    
    //MARK: - Memory
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//eom
    
}//eoc

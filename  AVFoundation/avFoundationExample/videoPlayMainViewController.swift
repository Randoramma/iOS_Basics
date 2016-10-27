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
    
    override func viewDidAppear(_ animated: Bool)
    {
        
    }//eom
    
    override func viewDidDisappear(_ animated: Bool)
    {
        
    }//eom
    
    
    
    // MARK:  - Choosing Video
    @IBAction func chooseVideoFromDevice(_ sender: AnyObject)
    {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .savedPhotosAlbum
        imagePickerController.mediaTypes = [kUTTypeMovie as String]
        imagePickerController.delegate = self
        
        self.present(imagePickerController, animated: true, completion: nil)
    }//eo-a
   
    
    // MARK:  Image Picker Delegates
    func imagePickerController(_ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : Any])
    {
        self.dismiss(animated: true, completion: nil)
        
        if let videoPlayer = self.storyboard?.instantiateViewController(withIdentifier: "VideoPlayer") as? VideoPlayerViewController
        {
            videoPlayer.videoURL = info[UIImagePickerControllerMediaURL] as? URL
            self.present(videoPlayer, animated: true, completion: nil)
        }
        else
        {
            print("un-able to start video player")
        }
        
    }//eom
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
    }//eom
    
    //MARK: - Memory
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//eom
    
}//eoc

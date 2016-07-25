//
//  CircularImageViewController.swift
//  cameraApp
//
//  Created by Luis Andres Castillo Hernandez on 11/19/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import UIKit

class CircularImageViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var imageChosen: UIImageView!
    
    @IBOutlet weak var importImageButton: UIButton!
    
    @IBOutlet weak var takePictureButton: UIButton!
    
    
    //MARK: View Loading
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        makeImageCircular()
    }
    
    
    //MARK: Update Image to Circular
    
    func makeImageCircular()
    {
        imageChosen.layer.cornerRadius = imageChosen.frame.size.width/2
        imageChosen.clipsToBounds = true
    }
    
    
    //MARK: Import Image
    
    @IBAction func importImageAction(sender: AnyObject)
    {
        
        let image = UIImagePickerController()
        
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = true
        
        self.presentViewController(image, animated: true, completion: nil)
        
    }//eo-action
    
    //MARK: take image
    
    @IBAction func takeImage(sender: AnyObject)
    {
        
        let image = UIImagePickerController()
        
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.Camera
        //image.allowsEditing = true
        
        self.presentViewController(image, animated: true, completion: nil)
    }//eo-action
    
    
    
    //MARK: Image Delegates
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?)
    {
        print("")
        print("didFinishPickingImage")
        print("image: \(image.debugDescription)")
        print("editingInfo: \(editingInfo.debugDescription)")
        print("")
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        imageChosen.image = image
        
    }//eom
    
    
    /* */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        print("")
        print("didFinishPickingMediaWithInfo")
        print("info: \(info)")
        print("")
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            imageChosen.image = image
        }
        
        dismissViewControllerAnimated(true,completion: nil)
    }//eom

    
    //MARK: Memory
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

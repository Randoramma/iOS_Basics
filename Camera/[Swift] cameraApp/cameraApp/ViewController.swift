//
//  ViewController.swift
//  cameraApp
//
//  Created by Luis Andres Castillo Hernandez on 11/19/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate
{

    @IBOutlet weak var imageChosen: UIImageView!
    @IBOutlet weak var importImageButton: UIButton!
    
    
    //MARK: View Loading
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        image.allowsEditing = true
        
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
    
//    func imagePickerControllerDidCancel(picker: UIImagePickerController)
//    {
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }//eo
    
    
    
    //MARK: Memory
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


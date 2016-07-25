//
//  AViewController.swift
//  cameraApp
//
//  Created by Luis Andres Castillo Hernandez on 11/19/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import UIKit

class AViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    @IBOutlet weak var imageChosen: UIImageView!
    @IBOutlet weak var importImageButton: UIButton!
    
    //MARK: View Loading
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    //MARK: Take Image
    
    @IBAction func takePicture(sender: AnyObject) {
        let image = UIImagePickerController()

        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.Camera
        image.allowsEditing = true

        self.presentViewController(image, animated: true, completion: nil)
    }
    
    
    
    //MARK: Image Delegates
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?)
    {        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        imageChosen.image = image
        
    }//eom
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        
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

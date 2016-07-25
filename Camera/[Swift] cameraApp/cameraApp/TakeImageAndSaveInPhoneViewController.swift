//
//  TakeImageAndSaveInPhoneViewController.swift
//  cameraApp
//
//  Created by Luis Andres Castillo Hernandez on 11/20/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import UIKit
import CoreData

class TakeImageAndSaveInPhoneViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate
{

    @IBOutlet weak var imageSavedInPhone: UIImageView!
    @IBOutlet weak var imageTaken: UIImageView!
    
    var userModel:User?
    
    //MARK: View Loading
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.makeImageCircular()
        
        self.getPhoto()
        
    }//eo-view
    
    
    //MARK: Update Image to Circular
    
    func makeImageCircular()
    {
        imageTaken.layer.cornerRadius = imageTaken.frame.size.width/2
        imageTaken.clipsToBounds = true
    }//eom
    
    
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
        
        //front camera
        image.cameraDevice = UIImagePickerControllerCameraDevice.Front
        
        
        
        image.allowsEditing = true
        
        self.presentViewController(image, animated: true, completion: nil)
    }//eo-action
    
    
    
    //MARK: Image Delegates
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage
                                image: UIImage,
                                editingInfo: [String : AnyObject]?)
    {
        print("")
        print("didFinishPickingImage")
        print("image: \(image.debugDescription)")
        print("editingInfo: \(editingInfo.debugDescription)")
        print("")
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        imageTaken.image = image
        
    }//eom
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        print("")
        print("didFinishPickingMediaWithInfo")
        print("info: \(info)")
        print("")
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            imageTaken.image = image
        }
        
        dismissViewControllerAnimated(true,completion: nil)
    }//eom
    
    //MARK: Actions
    
    @IBAction func saveImageToPhone(sender: AnyObject)
    {
        if(self.imageTaken.image != nil)
        {
            self.savePhoto()
        }
        
    }//eo-action
  
    
    //MARK: Core Data 
    
    func getPhoto()
    {
        do
        {
            let AppDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let theContext: NSManagedObjectContext = AppDel.managedObjectContext
            
            let request = NSFetchRequest(entityName: "User")
            
//            //one way of getting data
//            let userDataStored = try theContext.executeFetchRequest(request)
//            let firstDataSaved = userDataStored[0] as! NSManagedObject
//            
//            let imageData =  firstDataSaved.valueForKey("imageTaken") as! NSData
//            self.imageSavedInPhone.image = UIImage(data: imageData)
          
                //second way of getting data
                let userDataStored = try theContext.executeFetchRequest(request) as! [User]
            
                print("saved data in phone: \(userDataStored.debugDescription)")
                
                if userDataStored.count > 0
                {
                    let firstDataSaved = userDataStored[0]
                    
                    let imageData = firstDataSaved.imageTaken
                    self.imageSavedInPhone.image = UIImage(data: imageData!)

                    print("0: \(userDataStored[0])")
                }
        }
        catch let errorCatched as NSError
        {
            print("error retrieving data: \(errorCatched)")
        }
    }//eom
    
    
    func savePhoto()
    {
        let AppDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let theContext: NSManagedObjectContext = AppDel.managedObjectContext
        
        //delete all records
        do
        {
            let request         = NSFetchRequest(entityName: "User")
            let userDataStored  = try theContext.executeFetchRequest(request) as! [User]
        
            for currObject in userDataStored
            {
                theContext.deleteObject(currObject)
            }
            
        }
        catch let errorCatched as NSError
        {
            print("error deleting all data: \(errorCatched)")
        }
        
        
        
        //saving data
        
        //getting the description of the entity
        let theEntity = NSEntityDescription.entityForName("User", inManagedObjectContext: theContext)
        
        //creating the managed object to be inserted into core data
        let store = User(entity: theEntity!, insertIntoManagedObjectContext:theContext)
        
        //setting the attributes
        let image           = self.imageTaken.image
        let imageData       = UIImageJPEGRepresentation(image!, 1)
        store.imageTaken    = imageData
        
        //attempting to save data
        do {
            try theContext.save()
            print("image saved")
        }
        //catching errors
        catch let errorCatched as NSError
        {
           print("error saving data: \(errorCatched)")
        }
        
        //return to the previous view
        self.navigationController?.popViewControllerAnimated(true)
        
    }//eom
    
    
    
    //MARK: Memory
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}//eo

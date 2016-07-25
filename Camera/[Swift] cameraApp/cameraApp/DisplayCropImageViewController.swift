//
//  DisplayCropImageViewController.swift
//  cameraApp
//
//  Created by Luis Castillo on 2/19/16.
//  Copyright © 2016 devbros. All rights reserved.
//

import UIKit

class DisplayCropImageViewController: UIViewController {

    @IBOutlet weak var cropImageView: UIImageView!
    var imageToDisplay:UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cropImageView.image  = imageToDisplay
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }//eom


}

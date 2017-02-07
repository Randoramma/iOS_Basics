//
//  imageCaptureMainViewController.swift
//  avFoundationExample
//
//  Created by Luis Castillo on 2/11/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class imageCaptureMainViewController: UIViewController {

    
    //MARK: View Loading
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }//eom
    
    
    @IBAction func takePicture(_ sender: AnyObject)
    {
        let vc:imageCaptureViewController = imageCaptureViewController()
        
//        self.present(vc, animated: true)
//        { () -> Void in
//            
//        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
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

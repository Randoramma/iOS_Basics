//
//  PageContentViewController.swift
//  pageviewSample
//
//  Created by Luis Castillo on 7/24/16.
//  Copyright © 2016 LC. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var pageIndex:Int = 0;
    var titleText:String = ""
    var imageFile:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.image = UIImage(named: imageFile)
        self.titleLabel.text = titleText
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be rpoecreated.
    }
    

}

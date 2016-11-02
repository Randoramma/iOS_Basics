//
//  scrollviewWithActionsViewController.swift
//  scrollViews
//
//  Created by Luis Andres Castillo Hernandez on 11/27/15.
//  Copyright © 2015 ninestack. All rights reserved.
//

import UIKit

class scrollviewWithActionsViewController: UIViewController {

    //Static
    @IBOutlet weak var staticScrollview: UIScrollView!
    @IBOutlet weak var addButtonFromStatic: UIButton!
    @IBOutlet var staticImageViews: [UIImageView]!
    
    //DYNAMIC
    @IBOutlet weak var dynamicScrollview: UIScrollView!
    
    //Actions
    @IBOutlet weak var buttonLabel: UILabel!
    
    //Images
    var imageNames: [String]            = []
    var imagesList: [UIImage]           = []
    var imageviewList: [UIImageView]    = []
  
    
    var addTopicButton = UIButton.init(type: UIButtonType.custom)
    
    var totalImages = 0

    
    //setting default image size
    let imageSize:CGSize        = CGSize(width: 40, height: 40)
    

    
    
    // MARK: - View Loading
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //creating list of image names
        self.imageNames = [  "ATP World Tour.png",
            "Fantasy Sports.png",
            "FIFA.png",
            "MLB.png",
            "La Liga.png",
            "MLS.png",
            "WTA.png",
            "NCAA.png",
            "NFL.png",
            "NHL.png",
            "Olympics.png",
            "PGA Tour.png",
            "UFC.png",
            "Premier League.png"
        ]
        
        self.totalImages = imageNames.count
        
        
        
        
        self.setupStaticScrollview()
        
        self.setupDynamicScrollView()

    }//eo-view
    
    override func viewDidAppear(_ animated: Bool) {
        
    }//eo-view
    
    /*  */
    func setupStaticScrollview()
    {
        //updating scrollview size
        let calculatedImages = (self.totalImages+1)
        let rationWidthPerImage = Int(self.imageSize.width)
        
        let calculatedWidth = ( calculatedImages * rationWidthPerImage)
        let newWidth = CGFloat.init(integerLiteral: calculatedWidth)
        
        let origHeight  = staticScrollview.frame.height
        let origX       = staticScrollview.frame.origin.x
        let origY       = staticScrollview.frame.origin.y
        
        let caculatedScrollviewOrigin = CGPoint(x: origX, y: origY)
        let caculatedScrollviewSize = CGSize(width: newWidth, height: origHeight)
        
        staticScrollview.frame = CGRect.init(origin: caculatedScrollviewOrigin, size: caculatedScrollviewSize)
        
        staticScrollview.contentSize = caculatedScrollviewSize
        
        
        
//        print("scrollview: \(staticScrollview.debugDescription)")
//        print("")

//        print("subviews:")
        let scrollviewsSubviews = staticScrollview.subviews
        for iter in 0 ..< scrollviewsSubviews.count
        {
            let currView = scrollviewsSubviews[iter]
//            print("[\(iter)]  \(currView)")
//            print("")
        }//eofl
    }//eom
    
    /* dynamic scrollview setup */
    
    func setupDynamicScrollView()
    {
//        print(" - - - - - - - - - - - - - - - -")
//        print(" ")
//        print("init scrollview info: \(dynamicScrollview.debugDescription)")
//        print(" ")
//        
        //updating add topic button
        self.setupAndAddButtonToScrollview()
        
        var imageLocation:CGPoint   = CGPoint(x: 0.0, y: 0.0)
        
        
        //updating scrollview size
        let calculatedImages = (totalImages+1)
        let rationWidthPerImage = Int(imageSize.width)
        
        let calculatedWidth = ( calculatedImages * rationWidthPerImage)
        let newWidth = CGFloat.init(integerLiteral: calculatedWidth)
        
        let origHeight  = dynamicScrollview.frame.height
        let origX       = dynamicScrollview.frame.origin.x
        let origY       = dynamicScrollview.frame.origin.y
        
        let caculatedScrollviewOrigin = CGPoint(x: origX, y: origY)
        let caculatedScrollviewSize = CGSize(width: newWidth, height: origHeight)
        
        dynamicScrollview.frame = CGRect.init(origin: caculatedScrollviewOrigin, size: caculatedScrollviewSize)
        
        dynamicScrollview.contentSize = caculatedScrollviewSize
        
//        print("updated scrollview info: \(dynamicScrollview.debugDescription)")
//        print(" ")
        
        
        //creating UIImage and adding to UIImageView
        for iter in 0  ..< totalImages
        {
            //current image name
            let currImageName:String = imageNames[iter]
            
            //print("curr Image: [\(currImageName)")
            
            //current image
            let currImage = UIImage(named: currImageName)
            imagesList.append(currImage!)//adding to list
            
            //adding imageview
            let newPageView = UIImageView(image: currImage)
            newPageView.contentMode = .scaleAspectFit
            
            //frame size
            let imageDefaultWidth = Int(imageSize.width)
            let calculatedX       = (imageDefaultWidth * iter) + imageDefaultWidth
            imageLocation.x  = CGFloat.init(integerLiteral: calculatedX)
            
            //print("calculated frame: [\(imageLocation.x) , \(imageLocation.y)]")
            
            //setting imageview frame
            newPageView.frame   = CGRect.init(origin: imageLocation, size: imageSize)
            
            imageviewList.append(newPageView)//adding to list
            
            
            //print("curr ImageView: [\(newPageView)")
            
            //adding imageview to scrollview
            dynamicScrollview .addSubview(newPageView)
            
            //print(" ")
            //print(" ")
        }//eofl
    
    }//eom

    
    // MARK: - Action

    @IBAction func addTopic(_ sender: UIButton)
    {
        //getting time
        let date            = Date()
        let formatter       = DateFormatter()
        formatter.timeStyle = .short
        formatter.string(from: date)
        
        let buttonTagNum = sender.tag
        if(buttonTagNum == 2)
        {
            
            //updating time
            buttonLabel.text = "pressed by STATIC scrollview  - \(date)"
        }
    }//eo-action


      // MARK: - Setup & Add button programmatically for scrollview
    func setupAndAddButtonToScrollview()
    {
        //updating add topic button
        let buttonImage:UIImage       = UIImage(named: "add_topic.png")!
        let buttonLocation:CGPoint    = CGPoint(x: 0.0, y: 0.0)
        addTopicButton.frame = CGRect.init(origin: buttonLocation, size: imageSize)
        
        //adding background image
        addTopicButton.setBackgroundImage(buttonImage, for: UIControlState())
        
        addTopicButton.setBackgroundImage(buttonImage, for: .highlighted)
        
        addTopicButton.setBackgroundImage(buttonImage, for: .selected)
        
        //adding action to button
        addTopicButton.addTarget(self, action: #selector(scrollviewWithActionsViewController.pressedAction(_:)), for: .touchUpInside)
        
        
        //adding button to scrollview
        dynamicScrollview.addSubview(addTopicButton)
        
    
    }//eom
    
    func pressedAction(_ sender: UIButton!)
    {
    
        //getting time
        let date            = Date()
        let formatter       = DateFormatter()
        formatter.timeStyle = .short
        formatter.string(from: date)
        
        //updating time
        buttonLabel.text = "pressed by DYNAMIC scrollview  - \(date)"
    }//eom
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

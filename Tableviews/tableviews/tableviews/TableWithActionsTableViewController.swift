//
//  TableWithActionsTableViewController.swift
//  tableviews
//
//  Created by lu on 5/5/17.
//  Copyright © 2017 lc. All rights reserved.
//

import UIKit

class TableWithActionsTableViewController: UITableViewController {

    //MARK: - UI Properties
    @IBOutlet weak var table:UITableView!
    
    //MARK: - Properties
    let animals = ["Bear","Black Swan", "Buffalo","Panda", "Peacock", "Pig", "Platypus", "Polar Bear"]
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currIndex = indexPath.row
        let currData:String = animals[currIndex]
        
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as TableWithIndexListTableViewCell
        cell.configCell(currData)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //Share action
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal,
                                               title: "Share" ,
                                               handler: { (action:UITableViewRowAction!,
                                                indexPath:IndexPath!) -> Void in
                                       self.shareAction()
        })
        shareAction.backgroundColor = .red
        
        //Share action
        let shareWithImageAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal,
                                               title: "     " ,
                                               handler: { (action:UITableViewRowAction!,
                                                indexPath:IndexPath!) -> Void in
                                                self.shareAction()
        })
        
        /* Cell Action with Image*/
        let shareImage:UIImage? = UIImage(named: "star")
        
        //option 1
        let shareImageview:UIImageView = UIImageView(image: shareImage)
        shareImageview.contentMode = .scaleAspectFit
        if let starImage:UIImage = shareImageview.image {
            shareAction.backgroundColor = UIColor(patternImage: starImage)
        }
        
//        //option 2
//        let imgSize: CGSize = tableView.frame.size
//        UIGraphicsBeginImageContext(imgSize)
//        let shareImageframe = CGRect(x: 20, y: 0, width: 20, height: 20)
//        shareImage?.draw(in: shareImageframe )
//        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        if newImage != nil {
//            shareAction.backgroundColor = UIColor(patternImage: newImage!)
//        }
        
        // rate Action
        let rateAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Rate" , handler: { (action:UITableViewRowAction!, indexPath:IndexPath!) -> Void in
            self.shareAction()
        })
        
        return [shareAction,shareWithImageAction,rateAction]
    }
    
    //MARK: - Actions
    func shareAction(){
        let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .actionSheet)
        
        let twitterAction = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        shareMenu.addAction(twitterAction)
        shareMenu.addAction(cancelAction)
        
        
        self.present(shareMenu, animated: true, completion: nil)
    }
    
    func rateAction(){
        let rateMenu = UIAlertController(title: nil, message: "Rate this App", preferredStyle: .actionSheet)
        
        let appRateAction = UIAlertAction(title: "Rate", style: UIAlertActionStyle.default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        rateMenu.addAction(appRateAction)
        rateMenu.addAction(cancelAction)
        
        
        self.present(rateMenu, animated: true, completion: nil)
    }
}

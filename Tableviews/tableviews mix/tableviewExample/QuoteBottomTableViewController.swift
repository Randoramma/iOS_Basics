//
//  QuoteBottomTableViewController.swift
//  tableviewExample
//
//  Created by Luis Castillo on 2/26/17.
//  Copyright © 2017 DevBros. All rights reserved.
//

import UIKit

class QuoteBottomTableViewController: UITableViewController {

    private var quotes:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        quotes = ["impossible is nothing",
                  "do or do not there is no try",
                  "Whether you think you can or you think you can't, you're right.",
                  "Excuses sound best to those making them",
                  "Although the world is full of suffering, it is also full of the overcoming of it.",
                  "The struggle ends when the gratitude begins.",
                  "The future depends on what we do in the present.",
                  "If you don`t like something, change it. If you can`t change it, change your attitude. Don`t complain.",
                  "If you’re going through hell, keep going.",
                  "I know where I’m going and I know the truth, and I don’t have to be what you want me to be. I’m free to be what I want.",
                  "Never be afraid to try something new. Remember, amateurs built the ark; professionals built the Titanic."]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }//eom

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }//eom
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "quoteBottomCell", for: indexPath)

        cell.textLabel?.text = quotes[indexPath.row]

        return cell
    }//eom
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let scrollOffset : CGFloat = scrollView.contentOffset.y
        let scrollHeight : CGFloat = scrollView.frame.size.height
        
        let scrollContentSizeHeight : CGFloat = scrollView.contentSize.height + scrollView.contentInset.bottom
        
         _  = self.tableView.frame
        
        if (scrollOffset + scrollHeight) >= scrollContentSizeHeight {
            self.bottomRefreshAnimation()
        }
        else {
            if self.tableView.frame.origin.y < 0 {
                UIView.animate(withDuration: 0.2, delay: 0.0,
                               options: UIViewAnimationOptions.curveEaseInOut,
                               animations:
                    { () -> Void in
                    self.tableView.frame.origin.y = self.tableView.frame.origin.y + 40
                }, completion: nil)
            }
        }
    }//eom
   
    func bottomRefreshAnimation()
    {
        if self.tableView.frame.origin.y > 0 {
            
            UIView.animate(withDuration:0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations:
            { () -> Void in
                self.tableView.frame.origin.y = self.tableView.frame.origin.y - 40
            }, completion: nil)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
                UIView.animate(withDuration: 0.2, delay: 0.0,
                                           options: UIViewAnimationOptions.curveEaseInOut,
                                           animations:
                    { () -> Void in
                        if self.tableView.frame.origin.y < 0
                        {
                            self.tableView.frame.origin.y = self.tableView.frame.origin.y + 40
                        }
                    }, completion: nil)
            })
//            populateData({ (finished) -> () in
//                UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
//                    if self.tableView.frame.origin.y < 0 {
//                        self.tableView.frame.origin.y = self.tableView.frame.origin.y + 40
//                    }
//                }, completion: nil)
//            })
        }
    }
}

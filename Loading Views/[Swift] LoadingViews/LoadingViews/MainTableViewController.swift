//
//  MainTableViewController.swift
//  LoadingViews
//
//  Created by Luis Andres Castillo Hernandez on 11/18/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    
    var options:NSArray?
    
    //MARK: View Loading
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        options = [ "Push to NIB TableView" ,
                    "Load view inside a View",
                    "(Explicit) Load view from another SB",
                    "(Fancy) Load view from another SB",
                    "Containers",
                    "Pop Over"]
        
    }//eo-view
    
    
    override func viewDidAppear(animated: Bool)
    {
        
    }//eo-view
    
    //MARK: Memory

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let index = indexPath.row;
        
        print("selected row \(index)")
        if(index == 0)
        {
            let NIBController = TableViewController()
            
            self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
            
            self.navigationController?.pushViewController(NIBController, animated: true)
        }
        else if(index == 1)
        {   
           let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("loadViewFromView") as! AViewController
            
            self.navigationController?.navigationBar.barTintColor = UIColor.lightGrayColor()
            
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        else if(index == 2)
        {
            
            let aDiffStoryboard: UIStoryboard = UIStoryboard(name: "StoryboardTwo", bundle: nil)
            
            let thirdViewController = aDiffStoryboard.instantiateViewControllerWithIdentifier("viewInDiffSB") as! ADiffSBViewController
            
            self.navigationController?.navigationBar.barTintColor = UIColor.redColor()
            
            //replaces all views
            self.presentViewController(thirdViewController, animated: true, completion: nil)
            
            //pushes view onto stack
//            self.navigationController?.pushViewController(thirdViewController, animated: true)
        }
        else if (index == 3)
        {
            self.performSegueWithIdentifier("fancyVCPush", sender: self)
        }
        else if(index == 4)
        {
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("showContainer") as! MainContainerViewController
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        else if(index == 5)
        {
            let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("popOverContainer") as! VCThatCallsPopOverViewController
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }

        
        
        
    }//eom
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (options?.count)!
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:MainTableViewCell = (tableView.dequeueReusableCellWithIdentifier("mainCell", forIndexPath: indexPath) as? MainTableViewCell)!

        let index = indexPath.row
        cell.cellLabel.text = options![index] as? String
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}//eoc

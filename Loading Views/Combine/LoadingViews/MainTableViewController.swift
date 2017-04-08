//
//  MainTableViewController.swift
//  LoadingViews
//
//  Created by Luis Andres Castillo Hernandez on 11/18/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    enum options:Int
    {
        case containers  = 0
        case presentations  = 1
        case others  = 2
    }
    
    enum cell_container:Int {
        case loadViewInsideView = 0
        case segmentedViews = 1
        case menu = 2
        
        static let total:Int = 3
    }
    
    enum cell_presentations:Int {
        case popOver = 0
        case customPopOver = 1
        
        static let total:Int = 2
    }
    
    enum cell_other:Int {
        case tableviewNIB = 0
        case ViewControllerFromAnotherSB_Explicit = 1
        case ViewControllerFromAnotherSB_Segue = 2
        
        static let total:Int = 3
    }
    
    //MARK: View Loading
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }//eo-view

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath)
    {
        let sectionNum = (indexPath as NSIndexPath).section;
        let cellNum = (indexPath as NSIndexPath).row;
        
        //print("selected section \(sectionNum)")
        //print("selected row \(cellNum)")
        
        switch sectionNum
        {
            
            /* done in Storyboard */
            case options.containers.rawValue:
                switch cellNum {
                    case cell_container.loadViewInsideView.rawValue:
                        break
                    case cell_container.segmentedViews.rawValue:
                        break
                    case cell_container.menu.rawValue:
                        break
                    default:
                        break
                }
                
                break
            
            
            /* done in Storyboard */
            case options.presentations.rawValue:
                switch cellNum
                {
                    case cell_presentations.popOver.rawValue:
                        break
                    case cell_presentations.customPopOver.rawValue:
                        break
                    default:
                        break
                }
                
                break
            case options.others.rawValue:
                
                switch cellNum {
                    case cell_other.tableviewNIB.rawValue:
                        
                        let NIBController = TableViewController()
                        self.navigationController?.navigationBar.barTintColor = UIColor.blue
                        self.navigationController?.pushViewController(NIBController, animated: true)
                        
                        break
                    case cell_other.ViewControllerFromAnotherSB_Explicit.rawValue:
                        let aDiffStoryboard: UIStoryboard = UIStoryboard(name: "StoryboardTwo", bundle: nil)
            
                        let thirdViewController = aDiffStoryboard.instantiateViewController(withIdentifier: "viewInDiffSB") as! ADiffSBViewController
                        self.navigationController?.navigationBar.barTintColor = UIColor.red
                        self.navigationController?.pushViewController(thirdViewController, animated: true)
                        
                        break
                    case cell_other.ViewControllerFromAnotherSB_Segue.rawValue:
                        self.performSegue(withIdentifier: "segueVCPushToAnotherSB", sender: self)
                        break
                    default:
                        break
                }
                
                break
            default:
                break
        }
    }//eom
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 3
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int
    {
        switch section
        {
            case options.containers.rawValue:
                return cell_container.total
            case options.presentations.rawValue:
                return cell_presentations.total
            case options.others.rawValue:
                return cell_other.total
            default:
                return 0
        }
    }//eom
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell:UITableViewCell = super.tableView(tableView, cellForRowAt: indexPath)
        
        return cell
    }
   

}//eoc

//
//  TaskManagerTableViewController.swift
//  Task Manager
//
//  Created by Luis Andres Castillo Hernandez on 11/20/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import UIKit
import CoreData

class TaskManagerTableViewController: UITableViewController,NSFetchedResultsControllerDelegate {

    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.setupAppearance()
        
        fetchedResultController = getFetchedResultController()
        fetchedResultController.delegate = self
        do
        {
            try fetchedResultController.performFetch()
        }
        catch {
        }
        
    }

    //MARK: Memory
    
    func setupAppearance() {
        let navigationBarAppearance                 = UINavigationBar.appearance()
        navigationBarAppearance.barTintColor        = UIColor(red: 51.0/255.0, green: 104.0/255.0, blue: 121.0/255.0, alpha: 1.0)
        navigationBarAppearance.tintColor           = UIColor.whiteColor()
        navigationBarAppearance.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
    }//eom

    
    //MARK: Memory
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        let numberOfSections = fetchedResultController.sections?.count
        return numberOfSections!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let numberOfRowsInSection = fetchedResultController.sections?[section].numberOfObjects
        return numberOfRowsInSection!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
       
        
        let task = fetchedResultController.objectAtIndexPath(indexPath)
        if let currTask:Task = task as? Task
        {
            cell.textLabel?.text = currTask.desc
        }
        
        return cell
    }
   
    

    // MARK: - TableView Delete
    
     // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        let managedObject:NSManagedObject = fetchedResultController.objectAtIndexPath(indexPath) as! NSManagedObject
        managedObjectContext.deleteObject(managedObject)
        
        do
        {
            try managedObjectContext.save()
        }
        catch _ {
        }
    }//eom
    
    // MARK: - TableView Refresh
    
    func controllerDidChangeContent(controller: NSFetchedResultsController)
    {
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "editTask"
        {
            let cell        = sender as! UITableViewCell
            let indexPath   = tableView.indexPathForCell(cell)
            
            let taskController:TaskDetailViewController = segue.destinationViewController as! TaskDetailViewController
            
            let task = fetchedResultController.objectAtIndexPath(indexPath!) as? Task
            taskController.task = task
        }

    }//eom
    
    // MARK:- Retrieve Tasks
    
    func getFetchedResultController() -> NSFetchedResultsController
    {
        fetchedResultController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultController
    }//eom
    
    func taskFetchRequest() -> NSFetchRequest
    {
        let fetchRequest                = NSFetchRequest(entityName: "Task")
        let sortDescriptor              = NSSortDescriptor(key: "desc", ascending: true)
        fetchRequest.sortDescriptors    = [sortDescriptor]
        
        return fetchRequest
    }//eom


}

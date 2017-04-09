//
//  TaskDetailViewController.swift
//  Task Manager
//
//  Created by Luis Andres Castillo Hernandez on 11/20/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import UIKit
import CoreData

class TaskDetailViewController: UIViewController {

    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet var txtDesc: UITextField!
    
    var task:Task? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    // MARK: - actions

    
    @IBAction func done(sender: AnyObject) {
        if task != nil {
            editTask()
        } else {
            createTask()
        }
        dismissViewController()
    }
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewController()
    }
    
    func dismissViewController() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Creating Task
    func createTask()
    {
        let entityDescripition = NSEntityDescription.entityForName("Task", inManagedObjectContext: managedObjectContext)
        
        let task = Task(entity: entityDescripition!, insertIntoManagedObjectContext: managedObjectContext)
        task.desc = txtDesc.text!
        do
        {
            try managedObjectContext.save()
        }
        catch
        {
        
        }
    }//eom
    
    
    // MARK: - Editting task
    func editTask()
    {
        task?.desc = txtDesc.text!
        do
        {
            try managedObjectContext.save()
        }
        catch
        {
        
        }
    }//eom



}//eoc

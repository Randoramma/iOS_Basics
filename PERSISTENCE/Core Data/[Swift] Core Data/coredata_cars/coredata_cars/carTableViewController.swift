//
//  carTableViewController.swift
//  coredata_cars
//
//  Created by Luis Andres Castillo Hernandez on 11/20/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import UIKit
import CoreData

class carTableViewController: UITableViewController
{
    var List: Array<AnyObject> = []
    
      //MARK: view loading
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }//eo-view

    override func viewDidAppear(_ animated: Bool)
    {
        
        let AppDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let Context: NSManagedObjectContext = AppDel.managedObjectContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CarList")
        
        List = try! Context.fetch(request)
        tableView.reloadData()
    }//eo-view
    
    //MARK: memory
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return List.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell") as! carTableViewCell
        let data: NSManagedObject = List[indexPath.row] as! NSManagedObject
        
        cell.carMakeLabel?.text     = data.value(forKey: "carMake") as? String
        cell.carModelLabel?.text    = data.value(forKey: "carModel") as? String
        cell.carYearLabel?.text     = data.value(forKey: "carYear") as? String
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {

        let AppDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let Context: NSManagedObjectContext = AppDel.managedObjectContext

        if editingStyle == UITableViewCellEditingStyle.delete
        {

            Context.delete(List[indexPath.row] as! NSManagedObject)
            List.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)

        }

        var error: NSError? = nil

        do {

            try Context.save()

        }
        catch let error1 as NSError
        {
            error = error1
            print(error)
            abort()
        }



    }//eom


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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "editCar"
        {
            let selectedItem: NSManagedObject = List[self.tableView.indexPathForSelectedRow!.row] as! NSManagedObject
            
            let ViewCon: addCarViewController = segue.destination as! addCarViewController
            
            ViewCon.carmake     = selectedItem.value(forKey: "carmake") as! String
            ViewCon.carmodel    = selectedItem.value(forKey: "carmodel") as! String
            ViewCon.caryear     = selectedItem.value(forKey: "caryear") as! String
            
            ViewCon.existingItem = selectedItem
        }
        else if segue.identifier == "addCar"
        {
            
        }

    }//eo


}

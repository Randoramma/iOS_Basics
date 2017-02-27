//
//  TableViewController.swift
//  LoadingViews
//
//  Created by Luis Andres Castillo Hernandez on 11/18/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    
     // MARK: View
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let cellNib = UINib(nibName: "TableViewCell", bundle: nil)
        self.tableView .register(cellNib, forCellReuseIdentifier: "NIBCell")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
    }//eo-view

    override func viewDidDisappear(_ animated: Bool) {
//        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
    }//eo-view
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
     // MARK: Memory
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "NIBCell"
        
        let cell:TableViewCell = (tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? TableViewCell)!
        
        
        cell.NIBCellLabel.text = "Something Cool here"
        
        return cell
    }

    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    
}

//
//  ResultsTableViewController.swift
//  tableviews
//
//  Created by lu on 4/6/17.
//  Copyright © 2017 lc. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {

    //MARK: - Properties
    var baseData = [PersonsData]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(BaseTableViewCell.self)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return baseData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currIndex = indexPath.row
        let currData:PersonsData = baseData[currIndex]
        
        let cell:BaseTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath) as BaseTableViewCell
        cell.configCell(data:currData)
        
        return cell
    }

}

//
//  TableWithIndexListTableViewController.swift
//  tableviews
//
//  Created by lu on 4/7/17.
//  Copyright © 2017 lc. All rights reserved.
//

import UIKit

class TableWithIndexListTableViewController: UITableViewController {
    
    //MARK: - UI Properties
    @IBOutlet weak var table:UITableView!
    
    //MARK: - Properties
    let animals = [
                    ["Bear","Black Swan", "Buffalo"],
                    ["Camel", "Cockatoo"],
                    ["Dog", "Donkey"],
                    ["Emu"],
                    ["Giraffe", "Greater Rhea"],
                    ["Hippopotamus", "Horse"],
                    ["Koala"],
                    ["Lion", "Llama"],
                    ["Manatus", "Meerkat"],
                    ["Panda", "Peacock", "Pig", "Platypus", "Polar Bear"],
                    ["Rhinoceros"],
                    ["Seagull"],
                    ["Tasmania Devil"],
                    ["Whale", "Whale Shark", "Wombat"]
                ]
    
    let indexes = ["B","C","D","E","G","H","K","L","M","P","R","S","T","W"]
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - UITableViewDataSource
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return indexes
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return indexes[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return indexes.count    //note: this indexes amount is the SHOULD be the same as animals
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currIndex = indexPath.row
        let currSection = indexPath.section
        let currData:String = animals[currSection][currIndex]
        
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as TableWithIndexListTableViewCell
        cell.configCell(currData)
        return cell
    }
}

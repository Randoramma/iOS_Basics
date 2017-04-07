//
//  SearchBarEmbeddedTableViewController.swift
//  SearchBar
//
//  Created by Luis Castillo on 12/28/15.
//  Copyright © 2015. All rights reserved.
//

import UIKit

class SearchBarEmbeddedTableViewController: SearchResultsViewController
{
    // MARK: - Properties
    var searchController: UISearchController!
    
    // MARK: - Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        /*
        Create the search controller, but we'll make sure that this
        `SearchShowResultsInSourceViewController` performs the results updating.
        */
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        // Make sure the that the search bar is visible within the navigation bar.
        searchController.searchBar.sizeToFit()
        
        // Include the search controller's search bar within the table's header view.
        tableView.tableHeaderView = searchController.searchBar
        
        definesPresentationContext = true
    }//eo
    
}//eoc

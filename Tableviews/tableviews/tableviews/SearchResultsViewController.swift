//
//  SearchResultsViewController.swift
//  SearchBar
//
//  Created by Luis Castillo on 12/28/15.
//  Copyright © 2015. All rights reserved.
//

import UIKit

class SearchResultsViewController: SearchBaseTableViewController, UISearchResultsUpdating
{
    
    // MARK: Types
    struct StoryboardConstants
    {
        /**
         The identifier string that corresponds to the `SearchResultsViewController`'s
         view controller defined in the main storyboard.
         */
        static let identifier = "SearchResultsViewController"
    }//EO-struct
    
    // MARK: UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController)
    {
        /*
        `updateSearchResultsForSearchController(_:)` is called when the controller is
        being dismissed to allow those who are using the controller they are search
        as the results controller a chance to reset their state. No need to update
        anything if we're being dismissed.
        */
        guard searchController.isActive else { return }
        
        filterString = searchController.searchBar.text
    }//eom
}//eoc

//
//  SearchBaseTableViewController.swift
//  SearchBar
//
//  Created by Luis Castillo on 12/28/15.
//  Copyright © 2015 DevBros. All rights reserved.
//

import UIKit

class SearchBaseTableViewController: UITableViewController
{
    // MARK: - Properties
    let allResults = ["Here's", "to", "the", "crazy", "ones.", "The", "misfits.", "The", "rebels.", "The", "troublemakers.", "The", "round", "pegs", "in", "the", "square", "holes.", "The", "ones", "who", "see", "things", "differently.", "They're", "not", "fond", "of", "rules.", "And", "they", "have", "no", "respect", "for", "the", "status", "quo.", "You", "can", "quote", "them,", "disagree", "with", "them,", "glorify", "or", "vilify", "them.", "About", "the", "only", "thing", "you", "can't", "do", "is", "ignore", "them.", "Because", "they", "change", "things.", "They", "push", "the", "human", "race", "forward.", "And", "while", "some", "may", "see", "them", "as", "the", "crazy", "ones,", "we", "see", "genius.", "Because", "the", "people", "who", "are", "crazy", "enough", "to", "think", "they", "can", "change", "the", "world,", "are", "the", "ones", "who", "do."]
    
    lazy var visibleResults: [String] = self.allResults
    
    /// A `nil` / empty filter string means show all results. Otherwise, show only results containing the filter.
    var filterString: String? = nil
        {
        didSet
        {
            if filterString == nil || filterString!.isEmpty
            {
                visibleResults = allResults
            }
            else
            {
                // Filter the results using a predicate based on the filter string.
                let filterPredicate = NSPredicate(format: "self contains[c] %@", argumentArray: [filterString!])
                
                visibleResults = allResults.filter
                    { filterPredicate.evaluate(with: $0) }
            }
            
            tableView.reloadData()
        }//eo-didset
    }//eom
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return visibleResults.count
    }//eom
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        return tableView.dequeueReusableCell(withIdentifier: "searchResultsCell", for: indexPath)
    }//eom
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let currIndex:Int = indexPath.row
        let currData:String = visibleResults[currIndex]
        cell.textLabel!.text = currData
    }//eom

}

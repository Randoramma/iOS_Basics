//
//  TableWithCustomSearchBar.swift
//  tableviews
//
//  Created by lu on 4/7/17.
//  Copyright © 2017 lc. All rights reserved.
//

import UIKit

class TableWithCustomSearchBar: UIViewController {
    
    //MARK: - UI Properties
    @IBOutlet weak var tblSearchResults: UITableView!
    
    //MARK: - Properties
    var dataArray               = [String]()
    var filteredArray           = [String]()
    var shouldShowSearchResults = false
    
    //search controllers
    var customSearchController: CustomSearchController!
    var searchController: UISearchController!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadListOfCountries()
        configureCustomSearchController()
        setDelegates()
    }
    
    // MARK: - Data Request
    func loadListOfCountries() {
        // Specify the path to the countries list file.
        let pathToFile = Bundle.main.path(forResource: "countries", ofType: "txt")
        
        if let path = pathToFile {
            // Load the file contents as a string.
            let countriesString = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
            
            // Append the countries from the string to the dataArray array by breaking them using the line change character.
            dataArray = countriesString.components(separatedBy: "\n")
            
            tblSearchResults.reloadData()
        }
    }
}

// MARK: - CustomSearchController
extension TableWithCustomSearchBar:CustomSearchControllerDelegate {
    func configureCustomSearchController() {
        
        //search controller and bar settings
        let font:UIFont = UIFont(name: "Futura", size: 16.0)!
        let frame = CGRect(x: 0.0,
                           y: 0.0,
                           width: tblSearchResults.frame.size.width,
                           height: 50.0)
        let barTextColor = UIColor.orange
        let barTintColor = UIColor.black
        
        //setup
        customSearchController = CustomSearchController(searchResultsController: self,
                                                        searchBarFrame: frame,
                                                        searchBarFont: font,
                                                        searchBarTextColor: barTextColor,
                                                        searchBarTintColor: barTintColor,
                                                        hasBookmark: false,
                                                        hasCancel:true )
        
        customSearchController.customSearchBar.placeholder = "Search in this awesome bar..."
        customSearchController.customDelegate = self
        
        //setting bar in table header
        tblSearchResults.tableHeaderView = customSearchController.customSearchBar
    }
    
    // MARK: CustomSearchControllerDelegate functions
    func didStartSearching() {
        shouldShowSearchResults = true
        tblSearchResults.reloadData()
    }
    
    func didTapOnSearchButton() {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tblSearchResults.reloadData()
        }
    }
    
    func didTapOnCancelButton() {
        shouldShowSearchResults = false
        tblSearchResults.reloadData()
    }
    
    func didChangeSearchText(_ searchText: String) {
        // Filter the data array and get only those countries that match the search text.
        filteredArray = dataArray.filter({ (country) -> Bool in
            let countryText: NSString = country as NSString
            
            return (countryText.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        
        // Reload the tableview.
        tblSearchResults.reloadData()
    }
}

//MARK: - UITableViewDelegate
extension TableWithCustomSearchBar:UITableViewDelegate {
    func setDelegates(){
        tblSearchResults.delegate = self
        tblSearchResults.dataSource = self
    }
}

//MARK: - UITableViewDataSource
extension TableWithCustomSearchBar:UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return filteredArray.count
        }
        else {
            return dataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableWithCustomSearchBarCell", for: indexPath)
        
        if shouldShowSearchResults {
            cell.textLabel?.text = filteredArray[indexPath.row]
        }
        else {
            cell.textLabel?.text = dataArray[indexPath.row]
        }
        
        return cell
    }
}

// MARK: - Non-Custom Search Controller
extension TableWithCustomSearchBar:UISearchResultsUpdating, UISearchBarDelegate {
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater               = self
        searchController.dimsBackgroundDuringPresentation   = false
        searchController.searchBar.placeholder              = "Search here..."
        searchController.searchBar.delegate                 = self
        searchController.searchBar.sizeToFit()
        
        //setting bar in table header
        tblSearchResults.tableHeaderView = searchController.searchBar
    }
    
    // MARK: UISearchBarDelegate functions
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tblSearchResults.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tblSearchResults.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tblSearchResults.reloadData()
        }
        searchController.searchBar.resignFirstResponder()
    }
    
    // MARK: UISearchResultsUpdating delegate function
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else {
            return
        }
        
        // Filter the data array and get only the data that match the search text.
        filteredArray = dataArray.filter({ (country) -> Bool in
            let countryText:NSString = country as NSString
            
            return (countryText.range(of: searchString,
                                      options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        
        tblSearchResults.reloadData()
    }
}

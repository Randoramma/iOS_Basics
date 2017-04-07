//
//  TableWithSearchBarViewController.swift
//  tableviews
//
//  Created by lu on 4/6/17.
//  Copyright © 2017 lc. All rights reserved.
//

import UIKit

struct PersonsData {
    let index:String
    let data:[String]
    
    init(index:String, data:[String]) {
        self.index = index
        self.data = data
    }
}

class TableWithSearchBarViewController: UIViewController {

    //MARK: - UI properties
    @IBOutlet weak var searchTable:UITableView!
    
    //MARK: - Properties
   
    /// Search controller to help us with filtering.
    var searchController: UISearchController!
    
    /// Secondary search results table view.
    var resultsTableController: ResultsTableViewController!
    
    fileprivate var data:[PersonsData] = [
                                            PersonsData(index:"A" ,data:[
                                                "Andres",
                                                "Andrea",
                                                "Andy",
                                                "Artie",
                                                "Adrian",
                                                ]),
                                            PersonsData(index:"B" ,data:[
                                                "Bandres",
                                                "Bandrea",
                                                "Bandy",
                                                "Bartie",
                                                "badrian",
                                                ]),
                                            PersonsData(index:"D" ,data:[
                                                "Dean",
                                                "Di",
                                                "Dandy",
                                                "Dartie",
                                                "Dadrian",
                                                ]),
                                            PersonsData(index:"J" ,data:[
                                                "Jack",
                                                "James",
                                                "Jimmy",
                                                "John",
                                                "Johny",
                                                ]),
                                            PersonsData(index:"H" ,data:[
                                                "Hack",
                                                "Hames",
                                                "Himmy",
                                                "Hohn",
                                                "Hohny",
                                                ]),
                                            PersonsData(index:"K" ,data:[
                                                "Kack",
                                                "Kames",
                                                "Kimmy",
                                                "Kohn",
                                                "Kohny",
                                                ]),
                                            PersonsData(index:"L" ,data:[
                                                "Lack",
                                                "Lames",
                                                "Limmy",
                                                "Lohn",
                                                "Lohny",
                                                ]),
                                            PersonsData(index:"S" ,data:[
                                                "Stephanie",
                                                "Sara",
                                                "Sean",
                                                "Sofy",
                                                "Sarah",
                                                ])
                                        ]
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTable()
        setSearchController()
    }
    
    
    
    //MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UISearchResultsUpdating
extension TableWithSearchBarViewController:UISearchResultsUpdating {
    func setSearchController(){
        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        
        setBarDelegate()
        
        searchTable.tableHeaderView = searchController.searchBar
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let textSearching:String = searchController.searchBar.text else {
            return
        }
        
        let textSearchingWithoutSpaces:String = textSearching.trimmingCharacters(in: .whitespaces)
        let searchingItems = textSearchingWithoutSpaces.components(separatedBy: " ")
        
//        // Filter the results using a predicate based on the filter string.
//        let filterPredicate = NSPredicate(format: "self contains[c] %@", argumentArray: [filterString!])
//        
//        let visibleResults = allResults.filter
//            { filterPredicate.evaluate(with: $0) }
    }
}


// MARK: - UISearchBarDelegate
extension TableWithSearchBarViewController:UISearchBarDelegate{
    func setBarDelegate(){
        searchController.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
    }
}

// MARK: - UISearchControllerDelegate
extension TableWithSearchBarViewController:UISearchControllerDelegate{
    func presentSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
}

// MARK: - UITableViewDelegate
extension TableWithSearchBarViewController:UITableViewDelegate{
    fileprivate func setTable(){
        searchTable.register(BaseTableViewCell.self)
  
        searchTable.delegate = self
        searchTable.dataSource = self
        
        //secondary table configuration
        resultsTableController = ResultsTableViewController()
        resultsTableController.tableView.delegate = self
        
    }
}

// MARK: - UITableViewDataSource
extension TableWithSearchBarViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currIndex = indexPath.row
        let currData:PersonsData = data[currIndex]
        
        return UITableViewCell()
    }
    
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//
//    }
}

// MARK: -
extension TableWithSearchBarViewController{
    
}

// MARK: - Navigation
extension TableWithSearchBarViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}

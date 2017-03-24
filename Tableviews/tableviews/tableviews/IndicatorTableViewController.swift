//
//  IndicatorTableViewController.swift
//  tableviews
//
//  Created by lu on 3/24/17.
//  Copyright © 2017 lc. All rights reserved.
//

import UIKit

protocol IndicatorTableDelegate {
    func reached(position:TablePosition)
}

enum TablePosition {
    case Top
    case Bottom
}

class IndicatorTableViewController: UITableViewController {

    //MARK: - Properties
    fileprivate var busyIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var fetchInProgress = false
   
    var topOffset:CGFloat = -64.0
    
    var delegate:IndicatorTableDelegate?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupIndicator()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView){
        let reachedTop:Bool = scrollView.contentOffset.y < (topOffset - self.tableView.rowHeight);
        let reachedBottom:Bool = (scrollView.contentOffset.y + scrollView.frame.size.height) == scrollView.contentSize.height;
        
        if reachedTop {
            self.refreshTable(top: true)
        }
        else if reachedBottom {
            self.refreshTable(top: false)
        }
    }
    
    //MARK: - refresh table
    func refreshTable(top:Bool){
        if fetchInProgress {
            return;
        }
        
        fetchInProgress = true
        
        if top {
            delegate?.reached(position: .Top)
        }
        else {
            delegate?.reached(position: .Bottom)
        }
    }
    
    //MARK: - Show/Hide Indicators
    func setupIndicator(){
        let frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 44)
        busyIndicator = UIActivityIndicatorView(frame: frame)
        busyIndicator.color = UIColor.black
        busyIndicator.startAnimating()
    }
    
    func topIndicator(show:Bool) {
        DispatchQueue.main.async {
            if show {
                self.tableView.tableHeaderView = self.busyIndicator
                
                if let headerBounds:CGRect = self.tableView.tableHeaderView?.bounds {
                    let headerLocation:CGRect = self.tableView.convert(headerBounds, from: self.tableView.tableHeaderView)
                    self.tableView.scrollRectToVisible(headerLocation, animated: true)
                }
            }
            else {
                self.tableView.tableHeaderView?.removeFromSuperview()
                self.tableView.tableHeaderView = nil

            }
        }
    }
    
    func bottomIndicator(show:Bool){
        DispatchQueue.main.async {
            if show {
                self.tableView.tableFooterView = self.busyIndicator
                if let headerBounds:CGRect = self.tableView.tableFooterView?.bounds {
                    let headerLocation:CGRect = self.tableView.convert(headerBounds, from: self.tableView.tableFooterView)
                    self.tableView.scrollRectToVisible(headerLocation, animated: true)
                }
            }
            else {
                self.tableView.tableFooterView?.removeFromSuperview()
                self.tableView.tableFooterView = nil
            }
        }
    }
    
    //MARK: - Helpers
    func numberOfCellsThatFitOnScreen()->Int {
        let calcCells:CGFloat = self.tableView.frame.size.height / self.tableView.rowHeight
        
        return Int(calcCells)
    }
    
    func createIndexPaths(start:Int, end:Int)->[IndexPath] {
        var indexpaths:[IndexPath] = []
        
        for iter in start..<end {
            let currIndex:IndexPath = IndexPath(row:iter,section:0)
            indexpaths.append(currIndex)
        }
        
        return indexpaths
    }
    
    func debugIndexpath(paths:[IndexPath]){
        for currPath:IndexPath in paths{
            print(currPath)
        }
    }
}

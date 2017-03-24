//
//  IndicatiorTableInViewController.swift
//
//  Created by lu on 3/24/17.
//  Copyright © 2017 lc. All rights reserved.
//

import UIKit

class IndicatiorTableInViewController: UIViewController {

    //MARK: - Properties
    fileprivate var busyIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    var table: UITableView?
    
    var fetchInProgress = false
    var topOffset:CGFloat = -64.0
    var queue:DispatchQueue = DispatchQueue.main
    var delegate:IndicatorTableDelegate?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension IndicatiorTableInViewController:UITableViewDelegate {
    func setDelegates(table:UITableView){
        self.table = table
        self.setupIndicator()
    }
}

extension IndicatiorTableInViewController:UITableViewDataSource {
    // MARK: - Table view data source
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //NEED TO OVERRIDE
        return 0
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //NEED TO OVERRIDE
        return UITableViewCell()
    }
    
     func scrollViewDidScroll(_ scrollView: UIScrollView){
        
        guard let tableView:UITableView = self.table else  {
            return
        }
        
        let reachedTop:Bool = scrollView.contentOffset.y < (topOffset - tableView.rowHeight);
        let reachedBottom:Bool = (scrollView.contentOffset.y + scrollView.frame.size.height) == scrollView.contentSize.height;
        
        if reachedTop {
            self.refreshTable(top: true)
        }
        else if reachedBottom {
            self.refreshTable(top: false)
        }
    }
}

extension IndicatiorTableInViewController {
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
        guard let tableView:UITableView = self.table  else  {
            return
        }
        
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44)
        busyIndicator = UIActivityIndicatorView(frame: frame)
        busyIndicator.color = UIColor.black
        busyIndicator.startAnimating()
    }
    
    func topIndicator(show:Bool) {
        guard let tableView:UITableView = self.table else  {
            return
        }
        
        queue.async {
            if show {
                tableView.tableHeaderView = self.busyIndicator
                
                if let headerBounds:CGRect = tableView.tableHeaderView?.bounds {
                    let headerLocation:CGRect = tableView.convert(headerBounds, from: tableView.tableHeaderView)
                    tableView.scrollRectToVisible(headerLocation, animated: true)
                }
            }
            else {
                tableView.tableHeaderView?.removeFromSuperview()
                tableView.tableHeaderView = nil
                
            }
        }
    }
    
    func bottomIndicator(show:Bool){
        guard let tableView:UITableView = self.table else  {
            return
        }
        
        queue.async {
            if show {
                tableView.tableFooterView = self.busyIndicator
                if let headerBounds:CGRect = tableView.tableFooterView?.bounds {
                    let headerLocation:CGRect = tableView.convert(headerBounds, from: tableView.tableFooterView)
                    tableView.scrollRectToVisible(headerLocation, animated: true)
                }
            }
            else {
                tableView.tableFooterView?.removeFromSuperview()
                tableView.tableFooterView = nil
            }
        }
    }
    
    func hideIndicators(){
        topIndicator(show: false)
        bottomIndicator(show: false)
    }
    
    //MARK: - Helpers
    func numberOfCellsThatFitOnScreen()->Int {
        guard let tableView = self.table  else  {
            return 0
        }
        
        let calcCells:CGFloat = tableView.frame.size.height / tableView.rowHeight
        
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

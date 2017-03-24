//
//  CenteredPagingTableViewController.swift
//  tableviewExample
//
//  Created by Luis Castillo on 2/26/17.
//  Copyright © 2017 lc. All rights reserved.
//

import UIKit

class CenteredPagingTableViewController: UITableViewController {

    
    private var quotes:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.decelerationRate = UIScrollViewDecelerationRateFast;
        
        quotes = ["impossible is nothing",
        "do or do not there is no try",
        "Whether you think you can or you think you can't, you're right.",
        "Excuses sound best to those making them",
        "Although the world is full of suffering, it is also full of the overcoming of it.",
        "The struggle ends when the gratitude begins.",
        "The future depends on what we do in the present.",
        "If you don`t like something, change it. If you can`t change it, change your attitude. Don`t complain.",
        "If you’re going through hell, keep going.",
        "I know where I’m going and I know the truth, and I don’t have to be what you want me to be. I’m free to be what I want.",
        "Never be afraid to try something new. Remember, amateurs built the ark; professionals built the Titanic."]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell:CenteredPagingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "quoteCell", for: indexPath) as? CenteredPagingTableViewCell
        {
            let currIndex:Int       = indexPath.row
            let currNumber:String   = quotes[currIndex]
            cell.numberLabel.text    = currNumber
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    //MARK: Scrolling/Paging
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate == false
        {
            self.scrollViewDidEndDecelerating(scrollView)
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //scrolling/paging to center of tableview
        let midX:CGFloat = scrollView.contentOffset.x
        let midY:CGFloat = scrollView.contentOffset.y + tableView.rowHeight
        let midPoint:CGPoint = CGPoint(x: midX, y: midY)
        
        if let indexPathToScrollTo: IndexPath = self.tableView.indexPathForRow(at: midPoint)
        {
            self.tableView.scrollToRow(at: indexPathToScrollTo, at: UITableViewScrollPosition.middle, animated: true)
        }
    }

}

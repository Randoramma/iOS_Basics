//
//  TopAndBottomIndicatorTableViewController.swift
//  tableviewExample
//
//  Created by Luis Castillo on 2/27/17.
//  Copyright © 2017 DevBros. All rights reserved.
//

import UIKit

class TopAndBottomIndicatorTableViewController: UITableViewController {

    private var busyIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    private var quotes:[String] = []
    private var fetchInProgress = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        self.setupIndicator()
    }//eom

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }//eom

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }//eom

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath)
        
        cell.textLabel?.text = quotes[indexPath.row]
        
        return cell
    }//eom
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let reachedTop:Bool = scrollView.contentOffset.y < (-64.0 - self.tableView.rowHeight);
        let reachedBottom:Bool = (scrollView.contentOffset.y + scrollView.frame.size.height) == scrollView.contentSize.height;
        
        if reachedTop
        {
            self.refreshTable(top: true)
        }
        else if reachedBottom
        {
            self.refreshTable(top: false)
        }
    }//eom
    
    //MARK: - Add Data Top/Bottom
    func getSomeData(dataToAdd:Int)->[String]
    {
        let extraQuotes:[String] = ["impossible is nothing",
            "do or do not there is no try",
            "Whether you think you can or you think you can't, you're right.",
            "Excuses sound best to those making them",
            "Although the world is full of suffering, it is also full of the overcoming of it.",
            "The struggle ends when the gratitude begins.",
            "The future depends on what we do in the present.",
            "If you don`t like something, change it. If you can`t change it, change your attitude. Don`t complain.",
            "If you’re going through hell, keep going.",
            "I know where I’m going and I know the truth, and I don’t have to be what you want me to be. I’m free to be what I want.",
            "Never be afraid to try something new. Remember, amateurs built the ark; professionals built the Titanic.",
            "If you change nothing, nothing will change.",
            "A goal without a plan is only a wish.",
            "Rules for happiness: something to do, someone to love, something to hope for.",
            "When you judge others, you do not define them; you define yourself.",
            "Keep your goals away from the trolls.",
            "You don't have to live your life the way other people expect you to.",
            "Always remember that the future comes one day at a time.",
            "It always seems impossible until it's done.",
            "Do not wish for an easy life. Wish for the strength to endure a difficult one.",
            "If you stand for nothing, you fall for anything",
            "When Anger rises, think of consequences.",
            "Before you embark on a journey of revenge, dig two caves.",
            "Don't cry because it's over, smile because it happened.",
            "Today you are You, that is truer than true. There is no one alive who is Youer than You.",
            "Sometimes the questions are complicated and the answers are simple.",
            "When you want to succeed as bad as you want to breathe, that's when you will be successful.",
            "All men are created equal, some work harder in pre-season.",
            "When you come to the end of your rope, tie a knot and hang on.",
            "Don't make a priority out of someone that has you as an option."]
        
        let totalExtraQuotes:UInt32 = UInt32(extraQuotes.count)
        
        var newData:[String] = []
        for iter in 0..<dataToAdd
        {
            let randomIndex:Int = Int(arc4random_uniform(totalExtraQuotes))
            let aRandomQuote:String = extraQuotes[randomIndex]
            newData.append(aRandomQuote)
            
            print("[\(iter)] quote: \(aRandomQuote)")
        }//eom
        
        print("[new quotes] with '\(newData.count)' elements")
        
        return newData
    }//eom
    
    //MARK: - Show/Hide Indicators
    func setupIndicator()
    {
        let frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 44)
        busyIndicator = UIActivityIndicatorView(frame: frame)
        busyIndicator.color = UIColor.black
        busyIndicator.startAnimating()
    }//eom
    
    func topIndicator_show()
    {
        DispatchQueue.main.async {
            self.tableView.tableHeaderView = self.busyIndicator
            
            if let headerBounds:CGRect = self.tableView.tableHeaderView?.bounds {
                let headerLocation:CGRect = self.tableView.convert(headerBounds, from: self.tableView.tableHeaderView)
                self.tableView.scrollRectToVisible(headerLocation, animated: true)
            }
        }
    }//eom
    
    func topIndicator_hide()
    {
        DispatchQueue.main.async {
            self.tableView.tableHeaderView?.removeFromSuperview()
            self.tableView.tableHeaderView = nil
        }
    }//eom
    
    func bottomIndicator_show()
    {
        DispatchQueue.main.async {
            self.tableView.tableFooterView = self.busyIndicator
            if let headerBounds:CGRect = self.tableView.tableFooterView?.bounds {
                let headerLocation:CGRect = self.tableView.convert(headerBounds, from: self.tableView.tableFooterView)
                self.tableView.scrollRectToVisible(headerLocation, animated: true)
            }
        }
    }//eom
    
    func bottomIndicator_hide()
    {
        DispatchQueue.main.async {
            self.tableView.tableFooterView?.removeFromSuperview()
            self.tableView.tableFooterView = nil
        }
    }//eom
    
    //MARK: - refresh table
    func refreshTable(top:Bool)
    {
        if fetchInProgress {
            return;
        }
        
        fetchInProgress = true
        
        if top
        {
            self.topIndicator_show()
            self.refreshTable_top()
        }
        else
        {
            self.bottomIndicator_show()
            self.refreshTable_below()
        }
    }//eom
    
    func refreshTable_top()
    {
        let newData:[String] = self.getSomeData(dataToAdd: 17)
        
        let data_limit:Int          = 25;
        //
        let existing_data_count:Int = self.quotes.count
        let new_data_count:Int      = newData.count
        let updated_data_count:Int  = new_data_count + existing_data_count
        
        var rows_to_delete:Int      = 0
        let rows_to_add:Int         = new_data_count
        let diff_in_size            = (data_limit - updated_data_count)
        
        //A. would adding the new data exceed the limit?
        if  diff_in_size < 0
        {
            rows_to_delete = (-1) * diff_in_size
        }//eom
        
        //B. creating indexes for cells to remove/add
        let indexPathToAdd:[IndexPath] = self.indexPath_addRows_top(section: 0,
                                                cellsToAdd: rows_to_add)
        let indexPathToRemove:[IndexPath] = self.indexPath_removeRows_bottom(section: 0,
                                                 currentCellSum: self.quotes.count,
                                                 cellsToRemove: rows_to_delete)
        
        //simulating a background fetch
        DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + 2.0))
        { [weak self] in
            
            //START
            self?.tableView.beginUpdates()
            
            //add new data with existing data
            self?.addData_top(newData: newData, excessAmount: rows_to_delete)
            
            //remove cells
            if indexPathToRemove.count > 0
            {
                self?.tableView.deleteRows(at: indexPathToRemove,
                                           with: UITableViewRowAnimation.none)
            }
            
            //add cells
            self?.tableView.insertRows(at: indexPathToAdd,
                                       with: UITableViewRowAnimation.none)
            
            //moving scrollview back to location prior insertion
            if let tableviewRowHeight:CGFloat = self?.tableView.rowHeight
            {
                let estimatedRow:Int = Int(tableviewRowHeight) * (indexPathToAdd.count - 2)
                let estimatedPoint:CGPoint = CGPoint(x: 0, y: estimatedRow)
                self?.tableView .setContentOffset(estimatedPoint, animated: false)
            }
            
            
            //END
            self?.tableView.endUpdates()
            
            self?.fetchInProgress = false
            
            self?.topIndicator_hide()
        }
    }//eom
    
    func refreshTable_below()
    {
        let newData:[String] = self.getSomeData(dataToAdd: 17)
        
        let data_limit:Int          = 25;
        //
        let existing_data_count:Int = self.quotes.count
        let updated_data_count:Int  = newData.count + existing_data_count
        
        var rows_to_delete:Int      = 0
        let diff_in_size            = (data_limit - updated_data_count)
        
        //A. would adding the new data exceed the limit?
        if  diff_in_size < 0
        {
            rows_to_delete = (-1) * diff_in_size
        }//eom
        
        let rows_to_add:Int         = newData.count - rows_to_delete
        
        //B. creating indexes for cells to remove/add
        let indexPathToAdd:[IndexPath] = self.indexPath_addRows_bottom(section: 0,
                                            currentCellSum: existing_data_count,
                                            cellsToAdd: rows_to_add)
        let indexPathToRemove:[IndexPath] = self.indexPath_removeRows_top(section: 0,
                                                cellsToRemove: rows_to_delete)
        
        //simulating a background fetch
        DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + 2.0))
        { [weak self] in
            
            //START
            self?.tableView.beginUpdates()
            
            print("current sum: ", self?.quotes.count)
            //add new data with existing data
            self?.addData_below(newData: newData, excessAmount: rows_to_delete)
            
            print("updated sum: ", self?.quotes.count)
            
            //remove cells
//            if indexPathToRemove.count > 0
//            {
//                self?.tableView.deleteRows(at: indexPathToRemove,with: UITableViewRowAnimation.none)
//            }
            
            //add cells
            self?.tableView.insertRows(at: indexPathToAdd,
                                       with: UITableViewRowAnimation.none)
            
            //END
            self?.tableView.endUpdates()
            
            self?.fetchInProgress = false
            
            self?.bottomIndicator_hide()
        }
    }//eom
    
    func addData_top(newData:[String], excessAmount:Int)
    {
        var amountToRemove:Int = excessAmount
        for iter in 1...newData.count
        {
            //insert on top of data
            let lastIndex:Int = newData.count - iter
            let currData:String = newData[lastIndex]
            self.quotes .insert(currData, at: 0)
            
            //removing excess data
            if amountToRemove > 0
            {
                self.quotes .removeLast()
                amountToRemove = amountToRemove - 1
            }
        }//eofl
    }//eom
    
    func addData_below(newData:[String], excessAmount:Int)
    {
        var amountToRemove:Int = excessAmount
        for iter in 0..<newData.count
        {
            //insert on top of data
            let currData:String = newData[iter]
            self.quotes .append(currData)
            
            //removing excess data
            if amountToRemove > 0
            {
                self.quotes .removeFirst()
                amountToRemove = amountToRemove - 1
            }
        }//eofl
    }//eom
    
    //MARK: - IndexPath Helpers
    func numberOfCellsThatFitOnScreen()->Int
    {
        let calcCells:CGFloat = self.tableView.frame.size.height / self.tableView.rowHeight
        let cellsFitOnScreen:Int = Int(calcCells)
        
        return cellsFitOnScreen
    }//eom
    
    //MARK: - IndexPath Add
    func indexPath_addRows_top(section:Int, cellsToAdd:Int)->[IndexPath]
    {
        var indexPaths:[IndexPath] = []
        for iter in 0..<cellsToAdd
        {
            let currPath:IndexPath = IndexPath(row: iter, section: section)
            indexPaths .append(currPath)
            
            print("[Adding] section: ", section, " row:", iter)
        }
        
        return indexPaths
    }//eom
    
    func indexPath_addRows_bottom(section:Int,
                                  currentCellSum:Int,
                                  cellsToAdd:Int)->[IndexPath]
    {
        var indexPaths:[IndexPath] = []
        let offsetValue:Int = (currentCellSum-1) >= 0 ? (currentCellSum-1) : 0
        
        for iter in 1...cellsToAdd
        {
//            let currRow:Int = currentCellSum - iter
            let currRow:Int = offsetValue + iter
            let currPath:IndexPath = IndexPath(row: currRow, section: section)
            indexPaths .append(currPath)
            
            print("[Adding] section: ", section, " row:", currRow)
        }
        
        return indexPaths
    }//eom
    
    //MARK: - IndexPath Remove
    func indexPath_removeRows_top(section:Int,
                                  cellsToRemove:Int)->[IndexPath]
    {
        var indexPaths:[IndexPath] = []
        for iter in 0..<cellsToRemove
        {
            let currRow:Int = iter
            let currPath:IndexPath = IndexPath(row: currRow, section: section)
            indexPaths.append(currPath)
            print("[Removing] section: ", section, " row:", currRow)
        }
        
        return indexPaths
    }//eom
    
    func indexPath_removeRows_bottom(section:Int,
                                     currentCellSum:Int,
                                     cellsToRemove:Int)->[IndexPath]
    {
        var indexPaths:[IndexPath] = []
        for iter in 1...cellsToRemove
        {
            let currRow:Int = currentCellSum - iter
            let currPath:IndexPath = IndexPath(row: currRow, section: section)
            indexPaths.append(currPath)
            print("[Removing] section: ", section, " row:", currRow)
        }
        
        return indexPaths
    }//eom
    
    //MARK: - IndexPath Reloading
    func indexPath_reloadingTop(section:Int,
                                cellsToShow:Int,
                                cellsToAdd:Int)->[IndexPath]
    {
        let starting:Int = cellsToAdd - cellsToShow
        
        var indexPaths:[IndexPath] = []
        for iter in 1...cellsToShow
        {
            let currRow:Int = starting + iter
            let currPath:IndexPath = IndexPath(row: currRow, section: section)
            indexPaths.append(currPath)
        }
        
        return indexPaths
    }//eom
    
    func indexPath_reloadingBottom(section:Int,
                                   cellsToShow:NSInteger,
                                   cellsToAdd:NSInteger,
                                   totalData:NSInteger)->[IndexPath]
    {
        let starting:Int = totalData - cellsToAdd
        
        var indexPaths:[IndexPath] = []
        for iter in starting...cellsToShow
        {
            let currRow:Int = iter
            let currPath:IndexPath = IndexPath(row: currRow, section: section)
            indexPaths.append(currPath)
        }
        
        return indexPaths
    }//eom
    
    //MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//eom
}

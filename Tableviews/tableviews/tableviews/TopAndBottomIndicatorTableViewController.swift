//
//  TopAndBottomIndicatorTableViewController.swift
//  tableviewExample
//
//  Created by Luis Castillo on 2/27/17.
//  Copyright © 2017 lc. All rights reserved.
//

import UIKit


class TopAndBottomIndicatorTableViewController: IndicatorTableViewController {
    
    //MARK: - Properties
    fileprivate var quotes:[String] = []
    fileprivate let data_limit:Int = 20
    fileprivate var lastNum = 100

    //MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK: - Datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath)

        cell.textLabel?.text = quotes[indexPath.row]

        return cell
    }
}

extension TopAndBottomIndicatorTableViewController:IndicatorTableDelegate {
    func reached(position: TablePosition) {
        switch position {
        case .Top:
            self.topIndicator(show: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: UInt64(3.0)), execute: {
                self.insertTopBatch()
            })
            break
        case .Bottom:
            self.bottomIndicator(show: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: UInt64(3.0)), execute: {
                self.insertBottomBatch()
            })
            break
        }
    }
}

extension TopAndBottomIndicatorTableViewController {
    
    //MARK: - New Data
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
        }
        
        print("[new quotes] with '\(newData.count)' elements")
        
        return newData
    }
    
    //MARK: - Add/Remove Data
    fileprivate func addData(onTop:Bool, data:[String]){
        for iter in 0..<data.count {
            if onTop {
                let currLastIndex = (data.count - 1) - iter
                let currItem = data[currLastIndex]
                quotes.insert(currItem, at: 0)
            }
            else {
                let currItem = data[iter]
                quotes.append(currItem)
            }
        }
    }

    fileprivate func removeData(fromTop:Bool, amountToRemove:Int){
        for _ in 0..<amountToRemove {
            if fromTop {
                self.quotes.removeFirst()
            }
            else {
                self.quotes.removeLast()
            }
        }
    }
    
    
    //MARK: - Insert Top/Bottom Batch
    func insertTopBatch(){
        let newData:[String] = getSomeData(dataToAdd: 5)

        let dataCountPriorInsertion = quotes.count

        let insertStartIndex:Int    = 0
        let insertEndIndex:Int      = newData.count
        var deleteStartIndex:Int    = 0
        var deleteEndIndex:Int      = 0

        //does new data exceed limit?
        var offset:Int = (data_limit - (quotes.count + newData.count) )
        if offset <  0 {
            offset = offset * -1

            deleteStartIndex = quotes.count - offset
            deleteEndIndex   = deleteStartIndex + offset
        }
        else {
            offset = 0
        }

        let indexPathsInserting     = self.createIndexPaths(start: insertStartIndex, end: insertEndIndex)
        let indexPathsDeleting      = self.createIndexPaths(start: deleteStartIndex, end: deleteEndIndex)

        print("data inserting \(newData.count)")
        print("prior insert \(dataCountPriorInsertion) | data total \(quotes.count)")
        print("indexpath inserting: \(indexPathsInserting.count) | indexpath deleting: \(indexPathsDeleting.count)")

        DispatchQueue.main.async {
            self.tableView.isUserInteractionEnabled = false
            self.tableView.beginUpdates()

            //adding new data
            self.addData(onTop: true, data: newData)

            //removing excess data
            self.removeData(fromTop: false, amountToRemove: offset)

            self.tableView.insertRows(at: indexPathsInserting, with: UITableViewRowAnimation.none)


            if indexPathsDeleting.count > 0 {
                self.tableView.deleteRows(at: indexPathsDeleting, with: UITableViewRowAnimation.none)
            }

            //moving scrollview back to location prior insertion
            let calcRow:Int = indexPathsInserting.count + offset
            let estimatedRow:Int = Int(self.tableView.rowHeight) * calcRow
            let estimatedPoint:CGPoint = CGPoint(x: 0, y: estimatedRow)
            self.tableView .setContentOffset(estimatedPoint, animated: false)

            self.fetchInProgress = false
            self.tableView.isUserInteractionEnabled = true
            self.tableView.endUpdates()
        }

        self.topIndicator(show: false)
    }

    func insertBottomBatch() {

        let newData:[String] = getSomeData(dataToAdd: 5)

        let dataCountPriorInsertion = quotes.count

        /* APPROACH C: Deleting and Inserting Cells
            - inserting and deleting indexpaths, if deleting moving the table/scrollview back to last location it was being presented
         */
        var insertStartIndex:Int    = dataCountPriorInsertion
        var insertEndIndex:Int      = quotes.count + newData.count
        var deleteStartIndex:Int    = 0
        var deleteEndIndex:Int      = 0

        //does new data exceed limit?
        var offset:Int = (data_limit - (quotes.count + newData.count) )
        if offset <  0 {
            offset = offset * -1

            insertStartIndex    = insertStartIndex - offset
            insertEndIndex      = insertStartIndex + newData.count
            deleteStartIndex = 0
            deleteEndIndex   = offset
        }
        else {
            offset = 0
        }

        let indexPathsInserting     = self.createIndexPaths(start: insertStartIndex, end: insertEndIndex)
        let indexPathsDeleting      = self.createIndexPaths(start: deleteStartIndex, end: deleteEndIndex)

        print("data inserting \(newData.count)")
        print("prior insert \(dataCountPriorInsertion) | data total \(quotes.count)")
        print("indexpath inserting: \(indexPathsInserting.count) | indexpath deleting: \(indexPathsDeleting.count)")

        DispatchQueue.main.async {
            self.tableView.isUserInteractionEnabled = false
            self.tableView.beginUpdates()

            //adding new data
            self.addData(onTop: false, data: newData)

            //removing excess data
            self.removeData(fromTop: true, amountToRemove: offset)


            self.tableView.insertRows(at: indexPathsInserting, with: UITableViewRowAnimation.top)

            if indexPathsDeleting.count > 0 {
                self.tableView.deleteRows(at: indexPathsDeleting, with: UITableViewRowAnimation.none)

                //moving scrollview back to location prior insertion
                let numCellsFitOnScreen:Int = Int((self.view.frame.size.height - 44) / self.tableView.rowHeight)
                let calcRow:Int = (self.quotes.count - indexPathsInserting.count - numCellsFitOnScreen)
                let estimatedRow:Int = Int(self.tableView.rowHeight) * calcRow
                let estimatedPoint:CGPoint = CGPoint(x: 0, y: estimatedRow)
                self.tableView .setContentOffset(estimatedPoint, animated: false)
            }

            self.fetchInProgress = false
            self.tableView.isUserInteractionEnabled = true
            self.tableView.endUpdates()
        }

            //APPROACH B: reload all new cells & the cells that were on the screen prior new data, after reloading all cells then scroll to the last cell that was on the screen
//            let numCellsFitOnScreen:Int = Int((self.view.frame.size.height - 44) / self.tableView.rowHeight)
//
//            //reload all cells (new data & previous data on screen)
//            var allIndexes:[IndexPath] = []
//            let reloadLastIndex = quotes.count
//            let reloadStartIndex = quotes.count - offset - numCellsFitOnScreen
//            for iter in reloadStartIndex..<reloadLastIndex {
//                let currIndex:IndexPath = IndexPath(row:iter, section:0)
//                allIndexes.append(currIndex)
//                print("[reload] row: \(iter)")
//            }
//            tableView.reloadRows(at: allIndexes, with: UITableViewRowAnimation.none)
//
//            //scrolling the last cell that was on screen prior the new data
//            let desiredRow:Int = (quotes.count - offset - numCellsFitOnScreen + 1)
//            let targetIndexPath:IndexPath = IndexPath(row: desiredRow, section:0)
//            DispatchQueue.main.async {
//                print("desiredRow: ", desiredRow)
//                self.tableView.scrollToRow(at: targetIndexPath, at: UITableViewScrollPosition.none, animated: true)
//            }
           
            //APPROACH A: Calculating the scrollview offset
//            let rowTargeting:CGFloat = CGFloat( quotes.count - offset)
//            let num:CGFloat = tableView.rowHeight * rowTargeting
//            let targetPoint:CGPoint = CGPoint(x: 0, y: num)
//
//            tableView.reloadData()
//            tableView.layoutIfNeeded()
//
//            DispatchQueue.main.async {
//                if let indexPathToScrollTo: IndexPath = self.tableView.indexPathForRow(at: targetPoint)
//                {
//                    print("indexPathToScrollTo: ", indexPathToScrollTo)
//                    self.tableView.scrollToRow(at: indexPathToScrollTo, at: UITableViewScrollPosition.bottom, animated: true)
//                }
//            }
        
        
        self.bottomIndicator(show:false)
    }
}

//
//class TopAndBottomIndicatorTableViewController: UITableViewController {
//
//    private var busyIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
//    private var fetchInProgress = false
//
//    
//    private var quotes:[String] = []
//    let data_limit:Int = 20
//    var lastNum = 100
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        quotes = ["impossible is nothing",
//                  "do or do not there is no try",
//                  "Whether you think you can or you think you can't, you're right.",
//                  "Excuses sound best to those making them",
//                  "Although the world is full of suffering, it is also full of the overcoming of it.",
//                  "The struggle ends when the gratitude begins.",
//                  "The future depends on what we do in the present.",
//                  "If you don`t like something, change it. If you can`t change it, change your attitude. Don`t complain.",
//                  "If you’re going through hell, keep going.",
//                  "I know where I’m going and I know the truth, and I don’t have to be what you want me to be. I’m free to be what I want.",
//                  "Never be afraid to try something new. Remember, amateurs built the ark; professionals built the Titanic."]
//        
//        self.setupIndicator()
//    }
//
//    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return quotes.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath)
//        
//        cell.textLabel?.text = quotes[indexPath.row]
//        
//        return cell
//    }
//    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView)
//    {
//        let reachedTop:Bool = scrollView.contentOffset.y < (-64.0 - self.tableView.rowHeight);
//        let reachedBottom:Bool = (scrollView.contentOffset.y + scrollView.frame.size.height) == scrollView.contentSize.height;
//        
//        if reachedTop
//        {
//            self.refreshTable(top: true)
//        }
//        else if reachedBottom
//        {
//            self.refreshTable(top: false)
//        }
//    }
//    
//    //MARK: - Add Data Top/Bottom
//    func getSomeData(dataToAdd:Int)->[String]
//    {
//        let extraQuotes:[String] = ["impossible is nothing",
//            "do or do not there is no try",
//            "Whether you think you can or you think you can't, you're right.",
//            "Excuses sound best to those making them",
//            "Although the world is full of suffering, it is also full of the overcoming of it.",
//            "The struggle ends when the gratitude begins.",
//            "The future depends on what we do in the present.",
//            "If you don`t like something, change it. If you can`t change it, change your attitude. Don`t complain.",
//            "If you’re going through hell, keep going.",
//            "I know where I’m going and I know the truth, and I don’t have to be what you want me to be. I’m free to be what I want.",
//            "Never be afraid to try something new. Remember, amateurs built the ark; professionals built the Titanic.",
//            "If you change nothing, nothing will change.",
//            "A goal without a plan is only a wish.",
//            "Rules for happiness: something to do, someone to love, something to hope for.",
//            "When you judge others, you do not define them; you define yourself.",
//            "Keep your goals away from the trolls.",
//            "You don't have to live your life the way other people expect you to.",
//            "Always remember that the future comes one day at a time.",
//            "It always seems impossible until it's done.",
//            "Do not wish for an easy life. Wish for the strength to endure a difficult one.",
//            "If you stand for nothing, you fall for anything",
//            "When Anger rises, think of consequences.",
//            "Before you embark on a journey of revenge, dig two caves.",
//            "Don't cry because it's over, smile because it happened.",
//            "Today you are You, that is truer than true. There is no one alive who is Youer than You.",
//            "Sometimes the questions are complicated and the answers are simple.",
//            "When you want to succeed as bad as you want to breathe, that's when you will be successful.",
//            "All men are created equal, some work harder in pre-season.",
//            "When you come to the end of your rope, tie a knot and hang on.",
//            "Don't make a priority out of someone that has you as an option."]
//        
//        let totalExtraQuotes:UInt32 = UInt32(extraQuotes.count)
//        
//        var newData:[String] = []
//        for iter in 0..<dataToAdd
//        {
//            let randomIndex:Int = Int(arc4random_uniform(totalExtraQuotes))
//            let aRandomQuote:String = extraQuotes[randomIndex]
//            newData.append(aRandomQuote)
//            
//            print("[\(iter)] quote: \(aRandomQuote)")
//        }
//        
//        print("[new quotes] with '\(newData.count)' elements")
//        
//        return newData
//    }
//    
//    //MARK: - Show/Hide Indicators
//    func setupIndicator()
//    {
//        let frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 44)
//        busyIndicator = UIActivityIndicatorView(frame: frame)
//        busyIndicator.color = UIColor.black
//        busyIndicator.startAnimating()
//    }
//    
//    func topIndicator_show()
//    {
//        DispatchQueue.main.async {
//            self.tableView.tableHeaderView = self.busyIndicator
//            
//            if let headerBounds:CGRect = self.tableView.tableHeaderView?.bounds {
//                let headerLocation:CGRect = self.tableView.convert(headerBounds, from: self.tableView.tableHeaderView)
//                self.tableView.scrollRectToVisible(headerLocation, animated: true)
//            }
//        }
//    }
//    
//    func topIndicator_hide()
//    {
//        DispatchQueue.main.async {
//            self.tableView.tableHeaderView?.removeFromSuperview()
//            self.tableView.tableHeaderView = nil
//        }
//    }
//    
//    func bottomIndicator_show()
//    {
//        DispatchQueue.main.async {
//            self.tableView.tableFooterView = self.busyIndicator
//            if let headerBounds:CGRect = self.tableView.tableFooterView?.bounds {
//                let headerLocation:CGRect = self.tableView.convert(headerBounds, from: self.tableView.tableFooterView)
//                self.tableView.scrollRectToVisible(headerLocation, animated: true)
//            }
//        }
//    }
//    
//    func bottomIndicator_hide()
//    {
//        DispatchQueue.main.async {
//            self.tableView.tableFooterView?.removeFromSuperview()
//            self.tableView.tableFooterView = nil
//        }
//    }
//    
//    //MARK: - refresh table
//    func refreshTable(top:Bool)
//    {
//        if fetchInProgress {
//            return;
//        }
//        
//        fetchInProgress = true
//        
//        if top
//        {
//            self.topIndicator_show()
//            self.insertTopBatch()
//        }
//        else
//        {
//            self.bottomIndicator_show()
//            self.insertBottomBatch()
//        }
//    }
//    
//    func insertTopBatch(){
//        let newData:[String] = getSomeData(dataToAdd: 5)
//        
//        let dataCountPriorInsertion = quotes.count
//        
//        let insertStartIndex:Int    = 0
//        let insertEndIndex:Int      = newData.count
//        var deleteStartIndex:Int    = 0
//        var deleteEndIndex:Int      = 0
//        
//        //does new data exceed limit?
//        var offset:Int = (data_limit - (quotes.count + newData.count) )
//        if offset <  0 {
//            offset = offset * -1
//            
//            deleteStartIndex = quotes.count - offset
//            deleteEndIndex   = deleteStartIndex + offset
//        }
//        else {
//            offset = 0
//        }
//        
//        let indexPathsInserting     = self.createIndexPaths(start: insertStartIndex, end: insertEndIndex)
//        let indexPathsDeleting      = self.createIndexPaths(start: deleteStartIndex, end: deleteEndIndex)
//        
//        print("data inserting \(newData.count)")
//        print("prior insert \(dataCountPriorInsertion) | data total \(quotes.count)")
//        print("indexpath inserting: \(indexPathsInserting.count) | indexpath deleting: \(indexPathsDeleting.count)")
//        
//        DispatchQueue.main.async {
//            self.tableView.isUserInteractionEnabled = false
//            self.tableView.beginUpdates()
//            
//            //adding new data
//            self.addData(onTop: true, data: newData)
//            
//            //removing excess data
//            self.removeData(fromTop: false, amountToRemove: offset)
//            
//            self.tableView.insertRows(at: indexPathsInserting, with: UITableViewRowAnimation.none)
//            
//            
//            if indexPathsDeleting.count > 0 {
//                self.tableView.deleteRows(at: indexPathsDeleting, with: UITableViewRowAnimation.none)
//            }
//            
//            //moving scrollview back to location prior insertion
//            let calcRow:Int = indexPathsInserting.count + offset
//            let estimatedRow:Int = Int(self.tableView.rowHeight) * calcRow
//            let estimatedPoint:CGPoint = CGPoint(x: 0, y: estimatedRow)
//            self.tableView .setContentOffset(estimatedPoint, animated: false)
//            
//            self.fetchInProgress = false
//            self.tableView.isUserInteractionEnabled = true
//            self.tableView.endUpdates()
//        }
//        
//        self.topIndicator_hide()
//    }
//    
//    func insertBottomBatch() {
//        
//        let newData:[String] = getSomeData(dataToAdd: 5)
//       
//        let dataCountPriorInsertion = quotes.count
//        
//        /* APPROACH C: Deleting and Inserting Cells
//            - inserting and deleting indexpaths, if deleting moving the table/scrollview back to last location it was being presented
//         */
//        var insertStartIndex:Int    = dataCountPriorInsertion
//        var insertEndIndex:Int      = quotes.count + newData.count
//        var deleteStartIndex:Int    = 0
//        var deleteEndIndex:Int      = 0
//        
//        //does new data exceed limit?
//        var offset:Int = (data_limit - (quotes.count + newData.count) )
//        if offset <  0 {
//            offset = offset * -1
//           
//            insertStartIndex    = insertStartIndex - offset
//            insertEndIndex      = insertStartIndex + newData.count
//            deleteStartIndex = 0
//            deleteEndIndex   = offset
//        }
//        else {
//            offset = 0
//        }
//        
//        let indexPathsInserting     = self.createIndexPaths(start: insertStartIndex, end: insertEndIndex)
//        let indexPathsDeleting      = self.createIndexPaths(start: deleteStartIndex, end: deleteEndIndex)
//
//        print("data inserting \(newData.count)")
//        print("prior insert \(dataCountPriorInsertion) | data total \(quotes.count)")
//        print("indexpath inserting: \(indexPathsInserting.count) | indexpath deleting: \(indexPathsDeleting.count)")
//
//        DispatchQueue.main.async {
//            self.tableView.isUserInteractionEnabled = false
//            self.tableView.beginUpdates()
//            
//            //adding new data
//            self.addData(onTop: false, data: newData)
//            
//            //removing excess data
//            self.removeData(fromTop: true, amountToRemove: offset)
//
//            
//            self.tableView.insertRows(at: indexPathsInserting, with: UITableViewRowAnimation.top)
//            
//            if indexPathsDeleting.count > 0 {
//                self.tableView.deleteRows(at: indexPathsDeleting, with: UITableViewRowAnimation.none)
//                
//                //moving scrollview back to location prior insertion
//                let numCellsFitOnScreen:Int = Int((self.view.frame.size.height - 44) / self.tableView.rowHeight)
//                let calcRow:Int = (self.quotes.count - indexPathsInserting.count - numCellsFitOnScreen)
//                let estimatedRow:Int = Int(self.tableView.rowHeight) * calcRow
//                let estimatedPoint:CGPoint = CGPoint(x: 0, y: estimatedRow)
//                self.tableView .setContentOffset(estimatedPoint, animated: false)
//            }
//            
//            self.fetchInProgress = false
//            self.tableView.isUserInteractionEnabled = true
//            self.tableView.endUpdates()
//        }
//        
//            //APPROACH B: reload all new cells & the cells that were on the screen prior new data, after reloading all cells then scroll to the last cell that was on the screen
////            let numCellsFitOnScreen:Int = Int((self.view.frame.size.height - 44) / self.tableView.rowHeight)
////            
////            //reload all cells (new data & previous data on screen)
////            var allIndexes:[IndexPath] = []
////            let reloadLastIndex = quotes.count
////            let reloadStartIndex = quotes.count - offset - numCellsFitOnScreen
////            for iter in reloadStartIndex..<reloadLastIndex {
////                let currIndex:IndexPath = IndexPath(row:iter, section:0)
////                allIndexes.append(currIndex)
////                print("[reload] row: \(iter)")
////            }
////            tableView.reloadRows(at: allIndexes, with: UITableViewRowAnimation.none)
////
////            //scrolling the last cell that was on screen prior the new data
////            let desiredRow:Int = (quotes.count - offset - numCellsFitOnScreen + 1)
////            let targetIndexPath:IndexPath = IndexPath(row: desiredRow, section:0)
////            DispatchQueue.main.async {
////                print("desiredRow: ", desiredRow)
////                self.tableView.scrollToRow(at: targetIndexPath, at: UITableViewScrollPosition.none, animated: true)
////            }
//           
//            //APPROACH A: Calculating the scrollview offset
////            let rowTargeting:CGFloat = CGFloat( quotes.count - offset)
////            let num:CGFloat = tableView.rowHeight * rowTargeting
////            let targetPoint:CGPoint = CGPoint(x: 0, y: num)
////
////            tableView.reloadData()
////            tableView.layoutIfNeeded()
////
////            DispatchQueue.main.async {
////                if let indexPathToScrollTo: IndexPath = self.tableView.indexPathForRow(at: targetPoint)
////                {
////                    print("indexPathToScrollTo: ", indexPathToScrollTo)
////                    self.tableView.scrollToRow(at: indexPathToScrollTo, at: UITableViewScrollPosition.bottom, animated: true)
////                }
////            }
//        
//        
//        self.bottomIndicator_hide()
//    }
//    
//    //MARK: - Helpers
//    fileprivate func addData(onTop:Bool, data:[String]){
//        for iter in 0..<data.count {
//            if onTop {
//                let currLastIndex = (data.count - 1) - iter
//                let currItem = data[currLastIndex]
//                quotes.insert(currItem, at: 0)
//            }
//            else {
//                let currItem = data[iter]
//                quotes.append(currItem)
//            }
//        }
//    }
//    
//    fileprivate func removeData(fromTop:Bool, amountToRemove:Int){
//        for _ in 0..<amountToRemove {
//            if fromTop {
//                self.quotes.removeFirst()
//            }
//            else {
//                self.quotes.removeLast()
//            }
//        }
//    }
//    
//    func numberOfCellsThatFitOnScreen()->Int {
//        let calcCells:CGFloat = self.tableView.frame.size.height / self.tableView.rowHeight
//        let cellsFitOnScreen:Int = Int(calcCells)
//        
//        return cellsFitOnScreen
//    }
//    
//    fileprivate func createIndexPaths(start:Int, end:Int)->[IndexPath] {
//        var indexpaths:[IndexPath] = []
//        
//        for iter in start..<end {
//            let currIndex:IndexPath = IndexPath(row:iter,section:0)
//            indexpaths.append(currIndex)
//        }
//        
//        return indexpaths
//    }
//    
//    func debugIndexpath(paths:[IndexPath]){
//        for currPath:IndexPath in paths{
//            print(currPath)
//        }
//    }
//    
//    //MARK: - DEBUG
//    func debugCurrentData(){
//        var currIter = 0
//        for currItem in quotes {
//            print("[\(currIter)] \(currItem)")
//            currIter = currIter + 1
//        }
//    }
//    
//    //MARK: - Memory
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//}

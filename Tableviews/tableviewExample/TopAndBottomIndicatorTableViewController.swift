//
//  TopAndBottomIndicatorTableViewController.swift
//  tableviewExample
//
//  Created by Luis Castillo on 2/27/17.
//  Copyright © 2017 DevBros. All rights reserved.
//

import UIKit

class TopAndBottomIndicatorTableViewController: UITableViewController {

    private let busyIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    private var quotes:[String] = []
    
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
    }//eom


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        

        return cell
    }
    
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
//            let randomIndex:UInt32 = arc4random_uniform(totalExtraQuotes)
//            let aRandomQuote:String = extraQuotes[randomIndex]
//            newData.append(aRandomQuote)
//            
//            print("[\(iter)] quote: \(aRandomQuote)")
        }//eom
        
        print("[new quotes] with '\(newData.count)' elements")
        
        return newData
    }//eom
    
    //MARK: - Show/Hide Indicators
    func topIndicator_show()
    {
        self.tableView.tableHeaderView = busyIndicator
    }//eom
    
    func topIndicator_hide()
    {
        self.tableView.tableHeaderView?.removeFromSuperview()
        self.tableView.tableHeaderView = nil
    }//eom
    
    func bottomIndicator_show()
    {
        self.tableView.tableFooterView = busyIndicator
    }//eom
    
    func bottomIndicator_hide()
    {
        self.tableView.tableFooterView?.removeFromSuperview()
        self.tableView.tableFooterView = nil
    }//eom
    
    //MARK: - IndexPath Add
//    func indexPath_addRows_top(cellsToAdd:NSInteger)->NSArray
//    {
//        
//    }//eom
//    
//    func indexPath_addRows_bottom(cellsToAdd:NSInteger)->NSArray
//    {
//        
//    }//eom
//    
//    //MARK: - IndexPath Remove
//    func indexPath_removeRows_top(cellsToRemove:NSInteger)->NSArray
//    {
//    
//    }//eom
//    
//    func indexPath_removeRows_bottom(cellsToRemove:NSInteger)->NSArray
//    {
//        
//    }//eom
//    
//    //MARK: - IndexPath Reloading
//    func indexPath_reloadingTop(cellsToShow:NSInteger,
//                                cellsToAdd:NSInteger,
//                                totalData:NSInteger)->NSArray
//    {
//        
//    }//eom
//    
//    func indexPath_reloadingBottom(cellsToShow:NSInteger,
//                                   cellsToAdd:NSInteger,
//                                   totalData:NSInteger)->NSArray
//    {
//        
//    }//eom

    
    //MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//eom
}

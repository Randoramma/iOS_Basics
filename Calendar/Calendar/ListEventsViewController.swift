//
//  ListEventsViewController.swift
//  Calendar
//
//  Created by lu on 4/17/17.
//  Copyright © 2017 lu. All rights reserved.
//

import UIKit
import EventKit

class ListEventsViewController: UIViewController {

    let calendar:CalendarModel = CalendarModel()
    
    var startDate:Date  = Date()
    var endDate:Date    = Date()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForCalendarChanges()
        calendar.requestPermission(type: .event)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        testSearchEvents()
    }
    
    //MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - notifications
    func storeChanged(_ notification:Notification){
        print("storeChanged: ", notification)
    }
    
    func registerForCalendarChanges(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector( storeChanged(_:) ),
                                               name: NSNotification.Name.EKEventStoreChanged,
                                               object: calendar.store)
    }
    
    //MARK: - Search Events
    func searchForEvents(){
        let events = calendar.searchEventsWith(start: startDate, end: endDate)
        for currEvent in events{
            print("currEvent: ", currEvent)
        }
    }
    
    //MARK: - Testing
    func testSearchEvents(){
        let dateformatter:Dateformatter = Dateformatter
        dateformatter.date
        let currentCalendar = NSCalendar.current
        
        //start date
        var startDateComponents:DateComponents = DateComponents()
        startDateComponents.day = -1
        
        if let start = currentCalendar.date(byAdding: startDateComponents, to: Date() ){
            startDate = start
        }
        
        //end date
        var endDateComponents:DateComponents = DateComponents()
        endDateComponents.year = 1
        
        if let end = currentCalendar.date(byAdding: endDateComponents, to: Date() ) {
            endDate = end
        }
        
        let events:[EKEvent] = calendar.searchEventsWith(start: startDate, end: endDate)
        for currEvent in events{
            let calendar:EKCalendar = currEvent.calendar
            print("calendar: ", calendar.title)
            
            let title = currEvent.title
            print("title: ", title)
            
            let
            let eventStartDate:Date = currEvent.startDate
            print()
            
            let eventEndDate:Date = currEvent.endDate
            
            
            
            
            let allDayEvent = currEvent.isAllDay
            if allDayEvent {
                print("All Day? Yes")
            }else {
                print("All Day? No")
            }
            
            if let organizer:EKParticipant = currEvent.organizer{
                if let organizerName = organizer.name{
                    print("organizer: ", organizerName)
                }
            }
            
            print(currEvent)
            print("-------------------------------- /n /n ")
        }
    }

}


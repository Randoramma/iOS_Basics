//
//  CalendarModel.swift
//  Calendar
//
//  Created by lu on 4/07/17.
//  Copyright © 2017 lu. All rights reserved.
//

import Foundation
import EventKit

struct CalendarModel {
    
    //MARK: - Properties
    let eventCalendar:EKCalendar?
    let reminderCalendar:EKCalendar?
    let store:EKEventStore
    
    //MARK: - Init
    init(eventIdentifier:String? = nil,
         reminderIdentifier:String? = nil) {
        
        self.store = EKEventStore()
        
        //event calendar
        if let eventIdentifier:String = eventIdentifier {
            self.eventCalendar = self.store.calendar(withIdentifier: eventIdentifier)
        }
        else {
            self.eventCalendar      = EKCalendar(for: .event, eventStore: self.store)
        }
      
        //reminder calendar
        if let reminderIdentifier:String = reminderIdentifier {
            self.reminderCalendar   = self.store.calendar(withIdentifier: reminderIdentifier)
        }
        else {
            self.reminderCalendar   = EKCalendar(for: .reminder, eventStore: self.store)
        }
    }
    
    //MARK: - Permission
    func accessGranted(type:EKEntityType)->Bool {
        let status:EKAuthorizationStatus = EKEventStore.authorizationStatus(for: type)
        switch status {
        case .authorized:
            return true
        case .notDetermined:
            return false
        case .denied, .restricted:
            return false
        }
    }

    func requestPermission(type:EKEntityType){
        if accessGranted(type: type){
            self.setupCalendar()
            return
        }
        
        store.requestAccess(to: type) { (granted:Bool, error:Error?) in
            if (error == nil) && granted {
                self.setupCalendar()
            }
            else {
            }
        }
    }
    
    //MARK: - Setup
    func setupCalendar(){
        
    }
    
    //MARK: - Create Events
    func createEvent(title:String, startDate:Date, endDate:Date) -> EKEvent{
        let event:EKEvent = EKEvent(eventStore: store)
        event.title     = title
        event.startDate = startDate
        event.endDate   = endDate
        
        return event
    }
    
    //MARK: - Save Events
    func updateEvent(event:EKEvent, span:EKSpan, deleting:Bool = false)->Bool {
        do{
            if deleting {
                try store.remove(event, span: span)
                return true
            }
            else {
                try store.save(event, span: span)
                return true
            }
        }catch{
            return false
        }
    }
    
    //MARK: - Retrieve Events
    func searchEventsWith(start:Date, end:Date, calendar:[EKCalendar]? = nil)->[EKEvent]{
        let predicate:NSPredicate = store.predicateForEvents(withStart: start,
                                                             end: end,
                                                             calendars: calendar)
        let events:[EKEvent] = store.events(matching: predicate)
        return events
    }
    
}

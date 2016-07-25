//
//  Employee.swift
//  swiftDiffClasses
//
//  Created by Luis Andres Castillo Hernandez on 11/20/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import Foundation


protocol Payable
{
    func pay()->  (basepay:Int, benefits:Int, deductions: Int, vacationTime: Int)
}

class Employee {
    
    let name:String
    let address:String
    let startDate:NSDate
    let type:String
    
    var department:String?
    var reportsTo: Employee?
    
    init(fullname: String, employeeAddress:String, employeeStartDate: NSDate, employeeType: String)
    {
        
        name        = fullname
        address     = employeeAddress
        startDate   = employeeStartDate
        type        = employeeType
        
    }//eo-init
    
    /* Inheritance , without protocol
    func pay() -> (basepay:Int, benefits:Int, deductions: Int, vacationTime: Int)
    {
    return (0,0,0,0)
    }
    */
}//

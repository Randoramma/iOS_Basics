//
//  HourlyEmployee.swift
//  swiftDiffClasses
//
//  Created by Luis Andres Castillo Hernandez on 11/20/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import Foundation

class HourlyEmployee: Employee, Payable
{
    let hourlyWage = 12
    let hoursWorked = 40
    let avaliableVacation = 0
    
    /* Inheritance , without protocol
    override func pay()->  (basepay:Int, benefits:Int, deductions: Int, vacationTime: Int)
    {
    return (hourlyWage * hoursWorked, 0 , 0, avaliableVacation)
    }
    
    */
    
    func pay()->  (basepay:Int, benefits:Int, deductions: Int, vacationTime: Int)
    {
        return (hourlyWage * hoursWorked, 0 , 0, avaliableVacation)
    }
    
    
    
}//eo-HourlyEmployee

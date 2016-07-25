//
//  Person.swift
//  swiftDiffClasses
//
//  Created by Luis Andres Castillo Hernandez on 11/20/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import UIKit
import Foundation

protocol AgeClasificationProtocol {
    var age: Int { get }
    func agetype() -> String
}

class Person {
    let firstname: String
    let lastname: String
    var age: Int
    
    init(firstname: String, lastname: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.age = 10
    }
}

extension Person : AgeClasificationProtocol {
    
    func fullname() -> String {
        return firstname + " " + lastname
    }
    
    func agetype() -> String {
        switch age {
        case 0...2:
            return "Baby"
        case 2...12:
            return "Child"
        case 13...19:
            return "Teenager"
        case let x where x > 65:
            return "Elderly"
        default:
            return "Normal"
        }
    }
}
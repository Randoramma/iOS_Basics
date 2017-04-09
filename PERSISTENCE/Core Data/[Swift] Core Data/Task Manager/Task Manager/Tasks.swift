//
//  Tasks.swift
//  Task Manager
//
//  Created by Luis Andres Castillo Hernandez on 11/20/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import Foundation
import CoreData

class Task: NSManagedObject {
    
    @NSManaged var desc: String
    
}
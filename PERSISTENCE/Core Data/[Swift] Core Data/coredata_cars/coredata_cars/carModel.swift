//
//  carModel.swift
//  coredata_cars
//
//  Created by Luis Andres Castillo Hernandez on 11/20/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import UIKit
import CoreData

class carModel: NSManagedObject {

    
    @NSManaged var carMake:String?
    @NSManaged var carModel:String?
    @NSManaged var carYear:String?
    
}//eoc

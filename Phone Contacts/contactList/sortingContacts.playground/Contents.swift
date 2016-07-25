//: Playground - noun: a place where people can play

import UIKit

var numbers = [0, 2, 3, 4, 1]

numbers.sort { (one, two) -> Bool in
    
   return one < two
}



var names = [
                "luis", "Willy", "Manuel"

            ]

names.sortInPlace()



var places = NSArray(objects: "Velvet Wedding","BlackGate", "Iron Throne")
places.sort
    { (First, Second) -> Bool in
    
    print("First:   \(First)")
    print("Second:  \(Second)")
    
    var firstName   = ""
    var lastName    = ""
        
        if let name = First as? String
        {
           firstName = name
        }
        
        
        if let name = Second as? String
        {
            lastName = name
        }
        
       return firstName.localizedCaseInsensitiveCompare(lastName) == NSComparisonResult.OrderedAscending
       
        
    return false
}

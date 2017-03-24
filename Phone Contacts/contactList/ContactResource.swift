//
//  ContactResource.swift
//  contactList
//
//  Created by lu on 3/21/17.
//  Copyright © 2017 Luis Castillo. All rights reserved.
//

//import Foundation
import UIKit
import Contacts

struct ContactResource {
    let id:String?
    let firstName:String?
    let lastName:String?
    let fullname:String
    let organization:Bool
    let phone:String?
    let email:String?
    let phones:[String]
    let emails:[String]
    var addresses:[PostalAddress]
    var address:PostalAddress?
    let image:UIImage?
    
    init(fullname:String,
         phones:[String],
         emails:[String],
         firstname:String? = nil,
         lastname:String? = nil,
         id:String? = nil,
         addresses:[PostalAddress] = [],
         image:UIImage? = nil,
         organization:Bool = false) {
        
        //default
        self.fullname   = fullname
        self.phones     = phones
        self.emails     = emails
        self.addresses  = addresses
        
        if phones.count > 0 {
            self.phone = phones.first!
        } else {
            self.phone = nil
        }
        
        if emails.count > 0 {
            self.email = emails.first!
        } else {
            self.email = nil
        }
        
        if addresses.count > 0 {
            self.address  = addresses.first!
        }
        
        
        //optional
        self.id             = id
        self.image          = image
        self.firstName      = firstname
        self.lastName       = lastname
        self.organization   = organization
    }
}


struct PostalAddress {
    let street:String
    let city:String
    let state:String
    let postalCode:String
    let country:String?
    let countryCode:String?
    
    init(street:String, city:String, state:String, postalCode:String, country:String? = nil, countryCode:String? = nil) {
        self.street         = street
        self.city           = city
        self.state          = state
        self.postalCode     = postalCode
        self.country        = country
        self.countryCode    = countryCode
    }
}


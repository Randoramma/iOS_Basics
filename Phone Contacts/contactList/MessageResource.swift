//
//  MessageResource.swift
//  contactList
//
//  Created by lu on 3/21/17.
//  Copyright © 2017 Luis Castillo. All rights reserved.
//

import Foundation

public struct MessageResource {
    let recipients:[String]
    let body:String
    let subject:String
    let type:MessageResourceType
    
    init(recipients:[String], body:String, subject:String, type:MessageResourceType = MessageResourceType.none ) {
        self.recipients = recipients
        self.body       = body
        self.subject    = subject
        self.type       = type
    }
}

public enum MessageResourceType {
    case email
    case phone
    case text
    case none
}

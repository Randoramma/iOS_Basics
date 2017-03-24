//
//  ContactParse.swift
//  contactList
//
//  Created by lu on 3/21/17.
//  Copyright © 2017 Luis Castillo. All rights reserved.
//

import UIKit
import Contacts

func parseContactsToResource(_ contacts: [CNContact])->[ContactResource] {
    
    var finalContacts:[ContactResource] = [ContactResource]()
    
    for currContact:CNContact in contacts {
        var id:String?
        var firstName:String?           = nil
        var lastName:String?            = nil
        var phones:[String]             = []
        var emails:[String]             = []
        var image:UIImage?              = nil
        var addresses:[PostalAddress]   = []
        var name:String                 = ""
        var organization:Bool           = false
        
        
        //id
        id = currContact.identifier
        
        //name
        if(currContact.isKeyAvailable(CNContactGivenNameKey)) {
            firstName   = currContact.givenName
            name        = currContact.givenName
        }
        
        if name.characters.count == 0 {
            if(currContact.isKeyAvailable(CNContactOrganizationNameKey)) {
                organization = true
                name = currContact.organizationName
            }
        }
        else {
            if(currContact.isKeyAvailable(CNContactFamilyNameKey)) {
                lastName = currContact.familyName
                name = name .appending(" \(currContact.familyName)")
            }
        }
        
        //phone
        if (currContact.isKeyAvailable(CNContactPhoneNumbersKey)) {
            let numbers:[CNLabeledValue<CNPhoneNumber>] = currContact.phoneNumbers
            for currNumber in numbers {
                let firstNum:CNPhoneNumber  = currNumber.value
                let phoneNumber:String      = firstNum.stringValue
                phones.append(phoneNumber)
            }
        }
        
        //email
        if(currContact.isKeyAvailable(CNContactEmailAddressesKey)) {
            let contactEmails:[CNLabeledValue<NSString>] = currContact.emailAddresses
            for currEmail in contactEmails{
                let contactEmail            = currEmail.value
                let currEmailString:String  = contactEmail as String
                emails.append(currEmailString)
            }
        }
        
        //image
        if (currContact.isKeyAvailable(CNContactImageDataKey)) {
            if let contactImageData:Data = currContact.imageData  {
                image = UIImage(data: contactImageData)
            }
        }
        
        //address
        if (currContact.isKeyAvailable(CNContactPostalAddressesKey)){
            let postalAddresses:[CNLabeledValue<CNPostalAddress>] = currContact.postalAddresses
            for currentPostalAddress in postalAddresses {
                let currentAddress:CNPostalAddress = currentPostalAddress.value
                
                let currAddress:PostalAddress = PostalAddress(street: currentAddress.street,
                                                              city: currentAddress.city,
                                                              state: currentAddress.state,
                                                              postalCode: currentAddress.postalCode,
                                                              country: currentAddress.country,
                                                              countryCode: currentAddress.isoCountryCode)
                addresses.append(currAddress)
            }
        }
        
        
        let currContactResource:ContactResource = ContactResource(fullname: name,
                                                                  phones: phones,
                                                                  emails: emails,
                                                                  firstname: firstName,
                                                                  lastname: lastName,
                                                                  id: id,
                                                                  addresses: addresses,
                                                                  image: image,
                                                                  organization:organization)
        finalContacts.append(currContactResource)
    }
    
    return finalContacts
}

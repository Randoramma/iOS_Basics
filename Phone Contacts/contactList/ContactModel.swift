//
//  ContactModel.swift
//
//  Created by lu on 3/21/17.
//

import Foundation
import Contacts
import ContactsUI

struct ContactModel {
    
    static public let shared:ContactModel = ContactModel()
    
    //MARK: - Properties
    fileprivate let contactStoreQueue = DispatchQueue(label: Bundle.main.bundleIdentifier!+".LocalContactStore", attributes: DispatchQueue.Attributes.concurrent)
    
    let store:CNContactStore = CNContactStore()
    
    fileprivate let contactKeysSearching:[CNKeyDescriptor] = [CNContactGivenNameKey as CNKeyDescriptor,
                                                              CNContactFamilyNameKey as CNKeyDescriptor,
                                                              CNContactBirthdayKey as CNKeyDescriptor,
                                                              CNContactPhoneNumbersKey as CNKeyDescriptor,
                                                              CNContactEmailAddressesKey as CNKeyDescriptor,
                                                              CNContactOrganizationNameKey as CNKeyDescriptor,
                                                              CNContactPostalAddressesKey as CNKeyDescriptor,
                                                              CNContactImageDataKey as CNKeyDescriptor
                                                             ]
    //MARK: - Lifetime
    
}



//MARK: - Permission
extension ContactModel {

    public func requestAuthorization(_ completion:@escaping (_ accessGranted:Bool)->Void){
        self.store.requestAccess(for: .contacts, completionHandler: { (granted:Bool, error:Error?)in
            completion(granted)
        })
    }
    
    public func checkAuthorization(_ completion:@escaping (_ accessGranted:Bool?)->Void){
        let currentStatus = CNContactStore.authorizationStatus(for: .contacts)
        switch currentStatus {
        case .authorized:
            completion(true)
            break
        case .notDetermined:
           completion(nil)
            break
        case .restricted, .denied:
            completion(false)
        }
    }
}

//MARK: - Fetching
extension ContactModel {

    public func fetchAllContainers(_ completion: @escaping (_ contacts:[CNContainer])->Void){
        var AllContainers:[CNContainer] = []
        
        contactStoreQueue.async {
            do {
                AllContainers =  try self.store.containers(matching: nil)
            }
            catch let error {
                print(error.localizedDescription)
            }
        }
        
        DispatchQueue.main.async {
            completion(AllContainers)
        }
    }
    
    public func fetchAllContacts(_ completion: @escaping (_ contacts:[CNContact])->Void){
        var results:[CNContact] = [CNContact]()
       
        let request:CNContactFetchRequest = CNContactFetchRequest(keysToFetch: contactKeysSearching)
        
        contactStoreQueue.async {
            do {
                try self.store.enumerateContacts(with: request, usingBlock: {(contact, status) -> Void in
                    results.append(contact)
                })
                
            } catch let error as NSError {
                print("Error \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                completion(results)
            }
        }
    }
    
    public func fetchContacts(with identifiers:[String] , completion: @escaping (_ contacts:[CNContact])->Void){
 
        var results:[CNContact] = [CNContact]()
        
        let fetchRequest:CNContactFetchRequest =  CNContactFetchRequest(keysToFetch: contactKeysSearching)
        fetchRequest.predicate = CNContact.predicateForContacts(withIdentifiers: identifiers)
        
        contactStoreQueue.async {
            do {
                try self.store.enumerateContacts(with: fetchRequest, usingBlock: { (contact:CNContact, status:UnsafeMutablePointer<ObjCBool>) in
                    results.append(contact)
                })
            }
            catch let error {
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                completion(results)
            }
        }
    }
    
    func fetchContactsWithName(_ name: String, completion: @escaping (_ contacts: [CNContact]) -> Void) {
        var result = [CNContact]()
        let predicate = CNContact.predicateForContacts(matchingName: name)
        
        contactStoreQueue.async {
            do {
                result = try self.store.unifiedContacts(matching: predicate, keysToFetch: self.contactKeysSearching)
                
            } catch let error as NSError {
                print("Error \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func fetchContactWithID(_ contactID: String, completion: @escaping (_ contacts: CNContact?) -> Void) {
        var result:CNContact? = nil
        
        let IDKeysSearching = [CNContactViewController.descriptorForRequiredKeys()]
        
        contactStoreQueue.async {
            do {
                result = try self.store.unifiedContact(withIdentifier: contactID, keysToFetch: IDKeysSearching)
                
            } catch let error as NSError {
                print("Error \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}

//MARK: - Sorting
extension ContactModel {
    public func sortByName(_ contacts:[CNContact])-> [CNContact] {
        let sortedContacts:[CNContact] = contacts.sorted { (first:CNContact, second:CNContact) -> Bool in
            var oneName:String = ""
            var twoName:String = ""
            
            //first
            if first.isKeyAvailable(CNContactGivenNameKey) {
                oneName = first.givenName
            }
            
            if oneName.characters.count ==  0 {
                if first.isKeyAvailable(CNContactOrganizationNameKey) {
                    oneName = first.organizationName
                }
            }
            
            if oneName.characters.count ==  0 {
                if first.isKeyAvailable(CNContactFamilyNameKey){
                    oneName = first.familyName
                }
            }
            
            //second
            if second.isKeyAvailable(CNContactGivenNameKey){
                twoName = second.givenName
            }
            
            if twoName.characters.count ==  0 {
                if second.isKeyAvailable(CNContactOrganizationNameKey) {
                    twoName = second.organizationName
                }
            }
            
            if twoName.characters.count ==  0 {
                if second.isKeyAvailable(CNContactFamilyNameKey) {
                    twoName = second.familyName
                }
            }
            
            return oneName.localizedCaseInsensitiveCompare(twoName) == ComparisonResult.orderedAscending
        }
        
        return sortedContacts
    }
}

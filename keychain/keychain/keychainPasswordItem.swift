//
//  keychainPassword.swift
//  keychain
//
//  Created by lu on 3/10/17.
//  Copyright © 2017 lu. All rights reserved.
//
import Foundation

struct KeychainPasswordItem {
    
    // MARK: - Types
    enum KeychainError: Error {
        case noPassword
        case unexpectedPasswordData
        case unexpectedItemData
        case unhandledError(status: OSStatus)
    }
    
    // MARK: - Properties
    let service: String
    let accessGroup: String?
    
    fileprivate(set) var account: String
    
    
    // MARK: - Intialization
    init(service: String, account: String, accessGroup: String? = nil) {
        self.service = service
        self.account = account
        self.accessGroup = accessGroup
    }
    
    // MARK: - Query Helper
    fileprivate static func keychainQuery(withService service: String,
                                          account: String? = nil,
                                          accessGroup: String? = nil) -> [String : AnyObject] {
        
        var query                           = [String : AnyObject]()
        query[kSecClass as String]          = kSecClassGenericPassword
        query[kSecAttrService as String]    = service as AnyObject?
        
        if let account = account {
            query[kSecAttrAccount as String] = account as AnyObject?
        }
        
        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
        }
        
        return query
    }
}


// MARK: - Retrieve
extension KeychainPasswordItem{
    func readPassword() throws -> String  {
        // Build a query to find the item
        var query = KeychainPasswordItem.keychainQuery(withService: service,
                                                       account: account,
                                                       accessGroup: accessGroup)
        query[kSecMatchLimit as String]         = kSecMatchLimitOne
        query[kSecReturnAttributes as String]   = kCFBooleanTrue
        query[kSecReturnData as String]         = kCFBooleanTrue
        
        // Try to fetch the existing keychain item that matches the query.
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        // Check the return status and throw an error if appropriate.
        if status == errSecItemNotFound  {
            throw KeychainError.noPassword
        }
        else if status != noErr  {
            throw KeychainError.unhandledError(status: status)
        }
        
        // Parse the password string from the result
        guard let existingItem = queryResult as? [String : AnyObject],
            let passwordData = existingItem[kSecValueData as String] as? Data,
            let password = String(data: passwordData, encoding: String.Encoding.utf8)
            else {
                throw KeychainError.unexpectedPasswordData
        }
        
        return password
    }
    
    static func passwordItems(forService service: String,
                              accessGroup: String? = nil) throws -> [KeychainPasswordItem] {
        // Build a query for all items that match the service and access group
        var query = KeychainPasswordItem.keychainQuery(withService: service, accessGroup: accessGroup)
        query[kSecMatchLimit as String]         = kSecMatchLimitAll
        query[kSecReturnAttributes as String]   = kCFBooleanTrue
        query[kSecReturnData as String]         = kCFBooleanFalse
        
        // Fetch matching items
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        // If no items were found
        guard status != errSecItemNotFound else {
            return []
        }
        
        // Throw an error if an unexpected status occurred
        if status != noErr  {
            throw KeychainError.unhandledError(status: status)
        }
        
        // Cast the query result to an array of dictionaries.
        guard let resultData = queryResult as? [[String : AnyObject]] else {
            throw KeychainError.unexpectedItemData
        }
        
        // Create a `KeychainPasswordItem` for each dictionary in the query result
        var passwordItems = [KeychainPasswordItem]()
        for result in resultData {
            guard let account  = result[kSecAttrAccount as String] as? String else {
                throw KeychainError.unexpectedItemData
            }
            
            let passwordItem = KeychainPasswordItem(service: service,
                                                    account: account,
                                                    accessGroup: accessGroup)
            passwordItems.append(passwordItem)
        }
        
        return passwordItems
    }
}

//MARK: - Store
extension KeychainPasswordItem{
    func savePassword(_ password: String) throws {
        // Encode the password into an Data object.
        let encodedPassword = password.data(using: String.Encoding.utf8)!
        
        do {
            // Check if an password item already exist in the keychain
            try _ = readPassword()
            
            // Update the existing item with the new password
            var attributesToUpdate = [String : AnyObject]()
            attributesToUpdate[kSecValueData as String] = encodedPassword as AnyObject?
            
            let query   = KeychainPasswordItem.keychainQuery(withService: service,
                                                             account: account,
                                                             accessGroup: accessGroup)
            let status  = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
            
            // Throw an error if an unexpected status occurred
            if status != noErr  {
                throw KeychainError.unhandledError(status: status)
            }
        }
        catch KeychainError.noPassword {
            //no password found, create dictionary for new item
            var newItem = KeychainPasswordItem.keychainQuery(withService: service,
                                                             account: account,
                                                             accessGroup: accessGroup)
            newItem[kSecValueData as String] = encodedPassword as AnyObject?
            
            // Add a the new item to the keychain
            let status = SecItemAdd(newItem as CFDictionary, nil)
            
            // Throw an error if an unexpected status occurred
            if status != noErr {
                throw KeychainError.unhandledError(status: status)
            }
        }
    }
}

//MARK: - Delete
extension KeychainPasswordItem{
    func deleteItem() throws {
        // Delete the existing item
        let query = KeychainPasswordItem.keychainQuery(withService: service,
                                                       account: account,
                                                       accessGroup: accessGroup)
        let status = SecItemDelete(query as CFDictionary)
        
        // Throw an error if an unexpected status occurred
        guard status == noErr || status == errSecItemNotFound else {
            throw KeychainError.unhandledError(status: status)
        }
    }
}

//MARK: - Rename Account
extension KeychainPasswordItem{
    mutating func renameAccount(_ newAccountName: String) throws {
        // Try to update an existing item with the new account name
        var attributesToUpdate = [String : AnyObject]()
        attributesToUpdate[kSecAttrAccount as String] = newAccountName as AnyObject?
        
        let query = KeychainPasswordItem.keychainQuery(withService: service,
                                                       account: self.account,
                                                       accessGroup: accessGroup)
        let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
        
        // Throw an error if an unexpected status occurred
        guard status == noErr || status == errSecItemNotFound else {
            throw KeychainError.unhandledError(status: status)
        }
        
        self.account = newAccountName
    }
}

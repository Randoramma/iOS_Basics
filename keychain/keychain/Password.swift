//
//  Password.swift
//  keychain
//
//  Created by lu on 3/10/17.
//  Copyright © 2017 lu. All rights reserved.
//

import Foundation

struct Password {
    //MARK: - Properties
    private var accountName:String = "myAccountName"
    private let passwordItem:KeychainPasswordItem
    
    //MARK: - Init
    init() {
        passwordItem = KeychainPasswordItem.init(service: KeychainConfiguration.serviceName,
                                                 account: accountName)

    }

    //MARK: - Save
    func savePassword(updatedPassword:String){
        do{
            try passwordItem.savePassword(updatedPassword)
        }
        catch{
            print("error saving password: ", error)
        }
    }
    
    //MARK: - Get
    func getPassword()->String?{
        if let password:String = getPassword(keychain_password_item: passwordItem){
            return password
        }
        return nil
    }
    
    func getPassword(keychain_password_item:KeychainPasswordItem)->String?{
        do{
            let passwordRetrieved:String = try keychain_password_item.readPassword()
            return passwordRetrieved
        }
        catch{
            print("error retrieving password: ", error)
        }
        return nil
    }
    
    
    func getAllPasswords()->[KeychainPasswordItem]{
        do{
            let items = try  KeychainPasswordItem.passwordItems(forService: KeychainConfiguration.serviceName)
            return items
        }
        catch {
            print("error retrieving all pasword items ", error)
        }
        return []
    }
    
    //MARK: - Delete
    func deletePassword(){
        do{
            try passwordItem.deleteItem()
        }
        catch{
            print("unable to delete password item")
        }
    }
}

//
//  ViewController.swift
//  keychain
//
//  Created by lu on 3/10/17.
//  Copyright © 2017 lu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Ui Properties
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var savePasswordButton: UIButton!
    @IBOutlet weak var passwordTextview: UITextView!
    
    //MARK: - Properties
    var password:String?
    fileprivate var accountName:String = ""
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
         resetTextview()
    }

    //MARK: - Actions
    @IBAction func savePasswordRequest(_ sender: Any) {
        savePassword()
    }
    
    fileprivate func savePassword(){
        if let updatedPassword:String = passwordTextfield.text{
            savePassword(updatedPassword: updatedPassword)
            resetTextview()
        }
    }
    
    //MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - Textview
extension ViewController{
    func resetTextview(){
        
        var passwordStrings = ""
        let passwordItemsList = getAllPassword()
        for currPasswordItem:KeychainPasswordItem in passwordItemsList{
            if let currPassword:String = getPassword(keychain_password_item: currPasswordItem) {
                passwordStrings.append("\n \(currPassword)")
            }
        }
        
        if passwordStrings.characters.count > 0{
            updateTextviewContent(text: passwordStrings)
        }else{
            updateTextviewContent(text: "un-able to get password list")
        }
    }
    
    private func updateTextviewContent(text:String){
        DispatchQueue.main.async {
            self.passwordTextview.text = text
        }
    }
}

//MARK: - Textfield
extension ViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        savePassword()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

//MARK: - Keychain
extension ViewController{
    func savePassword(updatedPassword:String){
        let password_item:KeychainPasswordItem = passwordItem()
        do{
            try password_item.savePassword(updatedPassword)
        }
        catch{
            print("error saving password: ", error)
        }
    }
    
    func getPassword(keychain_password_item:KeychainPasswordItem? = nil)->String?{
        
        let provPasswordItem:KeychainPasswordItem = keychain_password_item ?? passwordItem()
        
        do{
            let passwordRetrieved:String = try provPasswordItem.readPassword()
            return passwordRetrieved
        }
        catch{
            print("error retrieving password: ", error)
        }
        return nil
    }
    
    func getAllPassword()->[KeychainPasswordItem]{
        do{
          let items = try  KeychainPasswordItem.passwordItems(forService: KeychainConfiguration.serviceName)
            return items
        }
        catch {
            print("error retrieving all pasword items ", error)
        }
        return []
    }
    
    //MARK: Helper
    func passwordItem()->KeychainPasswordItem {
        return KeychainPasswordItem.init(service: KeychainConfiguration.serviceName, account: accountName)
    }
}


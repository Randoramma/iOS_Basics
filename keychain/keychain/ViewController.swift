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
    @IBOutlet weak var deletePasswordButton: UIButton!
    @IBOutlet weak var passwordTextview: UITextView!
    
    //MARK: - Properties
    fileprivate var passwordKeychain:Password = Password()
    
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
    
    
    @IBAction func deletePasswordRequest(_ sender: UIButton) {
        passwordKeychain.deletePassword()
        resetTextview()
    }
    
    fileprivate func savePassword(){
        if let updatedPassword:String = passwordTextfield.text{
            passwordKeychain.savePassword(updatedPassword: updatedPassword)
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
        let passwordItemsList = passwordKeychain.getAllPasswords()
        for currPasswordItem:KeychainPasswordItem in passwordItemsList{
            if let currPassword:String = passwordKeychain.getPassword(keychain_password_item: currPasswordItem) {
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

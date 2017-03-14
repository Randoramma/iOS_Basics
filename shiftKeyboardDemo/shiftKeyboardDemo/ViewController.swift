//
//  ViewController.swift
//  shiftKeyboardDemo
//
//  Created by Luis Castillo on 3/3/17.
//  Copyright © 2017 lc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - UI Properties
    @IBOutlet weak var nameTextfield: UITextField!
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
    }//eom
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }//eom
    
    //MARK: - Textfield
    @IBAction func nameEditingFinished(_ sender: UITextField)
    {
        sender.resignFirstResponder()
    }//eom
    
    //MARK: - Keyboard
    func keyboardWillShow(_ notification:Notification) {
        view.frame.origin.y = 0 - getKeyboardHeight(notification)
    }//eom
    
    func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }//eom
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat
    {
        if let userInfo:[AnyHashable : Any] = notification.userInfo
        {
            if let keyboardSize:NSValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue // of CGRect
            {
                return keyboardSize.cgRectValue.height
            }
        }
        
        return 0.0
    }//eom
    
    //MARK: - Subcribers/Unsubcribers
    func subscribeToKeyboardNotifications()
    {
        NotificationCenter.default.addObserver(self,
                       selector: #selector(keyboardWillShow(_:)),
                       name: .UIKeyboardWillShow,
                       object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: .UIKeyboardWillHide,
                                               object: nil)
    }//eom
    
    func unsubscribeFromKeyboardNotifications()
    {
        NotificationCenter.default.removeObserver(self,
                                                  name: .UIKeyboardWillShow,
                                                  object: nil)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: .UIKeyboardWillHide,
                                                  object: nil)
    }//eom


}


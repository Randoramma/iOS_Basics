//
//  ViewController.swift
//  textfield
//
//  Created by Luis Andres Castillo Hernandez on 11/17/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import UIKit

class TextfieldViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textfieldWithNoBorder: UITextField!
    @IBOutlet weak var textfieldWithBottomOnly: UITextField!
    
    //textfield that changes color
    @IBOutlet weak var textfieldChangesOnEdit: UITextField!
    
    var borderFORtextfieldChangesOnEdit:CALayer = CALayer()
    
    
    
     //MARK: View loading
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        self.textfieldWithNoBorder.removeBorders()
        self.textfieldWithBottomOnly.addBottomBorder(color: UIColor.red, borderWidth: 2.0)

        self.setupTextfieldThatChangesColorOnEdit()
    }//eom
    
    //MARK: - Textfield change of Touch
    func setupTextfieldThatChangesColorOnEdit()
    {
        let width           = CGFloat(1.5)
        borderFORtextfieldChangesOnEdit.borderColor  = UIColor.lightGray.cgColor
        borderFORtextfieldChangesOnEdit.frame        = CGRect(x: 0,
                                                              y: textfieldChangesOnEdit.frame.size.height - width,
                                                              width:  textfieldChangesOnEdit.frame.size.width,
                                                              height: textfieldChangesOnEdit.frame.size.height)
        
        borderFORtextfieldChangesOnEdit.borderWidth  = width
        textfieldChangesOnEdit.layer.addSublayer(borderFORtextfieldChangesOnEdit)
        textfieldChangesOnEdit.layer.masksToBounds = true
    }//eom
    
    private func updateTextfieldSelection(isSelected:Bool)
    {
        if isSelected
        {
            textfieldChangesOnEdit.textColor = UIColor.blue
            borderFORtextfieldChangesOnEdit.borderColor = UIColor.blue.cgColor
        }
        else
        {
            textfieldChangesOnEdit.textColor = UIColor.black
            borderFORtextfieldChangesOnEdit.borderColor = UIColor.lightGray.cgColor
        }
    }//eom
    
    //MARK: - Reset all Textfield selections
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        textfieldWithNoBorder .resignFirstResponder()
        textfieldWithBottomOnly .resignFirstResponder()
        textfieldChangesOnEdit .resignFirstResponder()
    }//eom
    
    //MARK: - Textfield delegates
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == textfieldChangesOnEdit
        {
            self.updateTextfieldSelection(isSelected: true)
        }
        
        
        return true
    }//eom
    
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    
        textField .resignFirstResponder()
        
        
        if textField == textfieldChangesOnEdit
        {
            self.updateTextfieldSelection(isSelected: false)
        }
        
        
        return true;
    }//eom
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField .resignFirstResponder()
        
        if textField == textfieldChangesOnEdit
        {
            self.updateTextfieldSelection(isSelected: false)
        }
        
        return true;
    }//eom
    
}//eoc


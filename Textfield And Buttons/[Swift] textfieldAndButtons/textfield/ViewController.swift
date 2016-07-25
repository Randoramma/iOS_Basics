//
//  ViewController.swift
//  textfield
//
//  Created by Luis Andres Castillo Hernandez on 11/17/15.
//  Copyright © 2015 devbros. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var buttonWithBorder: UIButton!
    
    @IBOutlet weak var textfieldWithNoBorder: UITextField!
    @IBOutlet weak var textfieldWithBottomOnly: UITextField!
    //
    
    @IBOutlet weak var autoResizeLabelTextfield: UITextField!
    @IBOutlet weak var AutoResizeLabel: UILabel!
    
    //textfield that changes color
    @IBOutlet weak var textfieldChangesOnEdit: UITextField!
    var borderFORtextfieldChangesOnEdit:CALayer = CALayer()
    
    
    
     //MARK: View loading
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool)
    {
        
        self.updateTextFieldWithBottomBorderOnly(textfieldWithBottomOnly);
        
        self.setupTextfieldThatChangesColorOnEdit()
        
        self.updateButtonWithBorder()
    }//eom

     //MARK: Memory
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:

    func updateTextFieldWithBottomBorderOnly(textfieldProvided:UITextField)
    {
        let border          = CALayer()
        let width           = CGFloat(1.5)
        border.borderColor  = UIColor.lightGrayColor().CGColor
        border.frame        = CGRect(x: 0, y: textfieldProvided.frame.size.height - width, width:  textfieldProvided.frame.size.width+7, height: textfieldProvided.frame.size.height)
        
        border.borderWidth  = width
        textfieldProvided.layer.addSublayer(border)
        textfieldProvided.layer.masksToBounds = true
        
        /*
        
        //objective-c
            CALayer *border = [CALayer layer];
            CGFloat borderWidth = 2;
            border.borderColor = [UIColor darkGrayColor].CGColor;
            border.frame = CGRectMake(0, textField.frame.size.height - borderWidth, textField.frame.size.width, textField.frame.size.height);
            border.borderWidth = borderWidth;
            [textField.layer addSublayer:border];
            textField.layer.masksToBounds = YES;
        */

    }//eom
    
    
    
    //MARK: textfield that changes color on edit
    
    /* setting up textfield with border */
    func setupTextfieldThatChangesColorOnEdit()
    {
        let width           = CGFloat(1.5)
        borderFORtextfieldChangesOnEdit.borderColor  = UIColor.lightGrayColor().CGColor
        borderFORtextfieldChangesOnEdit.frame        = CGRect(x: 0, y: textfieldChangesOnEdit.frame.size.height - width, width:  textfieldChangesOnEdit.frame.size.width+7, height: textfieldChangesOnEdit.frame.size.height)
        
        borderFORtextfieldChangesOnEdit.borderWidth  = width
        textfieldChangesOnEdit.layer.addSublayer(borderFORtextfieldChangesOnEdit)
        textfieldChangesOnEdit.layer.masksToBounds = true
    }//eom
    
    /* chaning textfield colors */
    @IBAction func textfieldEditModeON(sender: UITextField)
    {
        textfieldChangesOnEdit.textColor = UIColor.blueColor()
        borderFORtextfieldChangesOnEdit.borderColor = UIColor.blueColor().CGColor
    
    }//eoa
    
    /* returning textfield colors back to original colors */
    @IBAction func textfieldEditModeOFF(sender: UITextField)
    {
        textfieldChangesOnEdit.textColor = UIColor.blackColor()
        borderFORtextfieldChangesOnEdit.borderColor = UIColor.lightGrayColor().CGColor
    }//eoa
    
    
    //MARK: 
    
    /* releasing first responder if user clicks on background */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        textfieldWithNoBorder .resignFirstResponder()
        textfieldWithBottomOnly .resignFirstResponder()
        textfieldChangesOnEdit .resignFirstResponder()
  
    }//eom
    
    //MARK: textfield delegates
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
    
        textField .resignFirstResponder()
        
        return true;
    }//eom
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField .resignFirstResponder()
        
        if textField == autoResizeLabelTextfield
        {
            AutoResizeLabel.text = autoResizeLabelTextfield.text
            autoResizeLabelTextfield.text = ""
        }
        
        return true;
    }//eom
    
    //MARK: Buttons
    func updateButtonWithBorder()
    {
        
        self.buttonWithBorder.layer.borderWidth = 0.8
        self.buttonWithBorder.layer.borderColor = UIColor.redColor().CGColor
        
        //make round border
        self.buttonWithBorder.layer.cornerRadius = 10.0
        
    }//eom
    
}//eoc


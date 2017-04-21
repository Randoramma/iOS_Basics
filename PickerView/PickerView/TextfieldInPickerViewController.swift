//
//  TextfieldInPicker.swift
//  PickerView
//
//  Created by lu on 4/17/17.
//  Copyright © 2017 lu. All rights reserved.
//

import UIKit

class TextfieldInPickerViewController: UIViewController {
    //MARK: - UI Properties
    @IBOutlet weak var optionsTextfield: UITextField!
    
    //MARK: - Properties
    fileprivate let pickerView:UIPickerView = UIPickerView()
    fileprivate let options:[String] = ["Option A",
                                          "Option D",
                                          "Option H",
                                          "Option K",
                                          "Option T",
                                          "Option Z"]
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextfield()
        setPicker()
    }

    //MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK: - Picker
extension TextfieldInPickerViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func setPicker(){
        optionsTextfield.inputView = pickerView
        
        pickerView.delegate = self
        
        pickerView.contentMode      = .center
        pickerView.backgroundColor  = UIColor.lightGray
        pickerView.tintColor        = UIColor.black
        
        let toolBar = UIToolbar(frame: CGRect(x: 0,
                                              y: self.view.frame.size.height/6,
                                              width: self.view.frame.size.width,
                                              height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2,
                                         y: self.view.frame.size.height-20)
        toolBar.barStyle        = UIBarStyle.default
        toolBar.tintColor       = UIColor.black
        toolBar.backgroundColor = UIColor.white
        
        //options
        let cancelButton = UIBarButtonItem(title: "Cancel",
                                            style: UIBarButtonItemStyle.plain,
                                            target: self,
                                            action: #selector(cancelButtonPressed))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace,
                                        target: self,
                                        action: nil)
        
        //label
        let label = UILabel(frame: CGRect(x: 0,
                                          y: 0,
                                          width: self.view.frame.size.width/3,
                                          height: self.view.frame.size.height))
        label.font              = UIFont(name: "Helvetica-Bold", size: 14)
        label.backgroundColor   = UIColor.clear
        label.textColor         = UIColor.black
        label.text              = "Pick a option"
        label.textAlignment     = NSTextAlignment.center
        let textBtn             = UIBarButtonItem(customView: label)
        
        //done
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done,
                                         target: self,
                                         action: #selector(doneButtonPressed))
        
        let items = [cancelButton,flexSpace,textBtn,flexSpace,doneButton]
        toolBar.setItems(items,
                         animated: true)
        
        optionsTextfield.inputAccessoryView = toolBar
    }
    
    //MARK: Actions
    func doneButtonPressed(_ sender: UIBarButtonItem) {
        optionsTextfield.resignFirstResponder()
    }
    
    func cancelButtonPressed(_ sender: UIBarButtonItem) {
        optionsTextfield.text = ""
        optionsTextfield.resignFirstResponder()
    }
    
    //MARK:  Helper
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK:  Picker Delegates
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        optionsTextfield.text = options[row]
    }
}


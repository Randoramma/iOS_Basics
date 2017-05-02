//
//  TransitionSubviewViewController.swift
//  LoadingViews
//
//  Created by lu on 5/2/17.
//  Copyright © 2017 devbros. All rights reserved.
//

import UIKit

protocol subControllerDelegate:class {
    func subCancelPressed()
    func subSubmitPressed()
}

class TransitionSubviewViewController: UIViewController {
    
    //MARK: - UI Properties
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    //MARK: - Properties
    weak var delegate:subControllerDelegate?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.layer.cornerRadius = submitButton.frame.height/2
        cancelButton.layer.cornerRadius = cancelButton.frame.height/2
    }
    
    //MARK: - Action
    @IBAction func submitPressed(sender: UIButton){
        delegate?.subSubmitPressed()
    }
    
    @IBAction func cancelPressed(sender: UIButton){
        delegate?.subCancelPressed()
    }
}

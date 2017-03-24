//
//  ContactTableViewCell.swift
//  contactList
//
//  Created by Luis Castillo on 12/31/15.
//  Copyright © 2015 Luis Castillo. All rights reserved.
//

import UIKit
import Contacts

protocol ContactTableCellDelegate {
    func sendTextMessage(message:MessageResource)
    func sendEmailMessage(message:MessageResource)
}

class ContactTableViewCell: UITableViewCell {

    //MARK: - UI Properties
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactPhone: UILabel!
    
    @IBOutlet weak var contactTextMsgButton: UIButton!
    @IBOutlet weak var contactEmailButton: UIButton!
    
    //MARK: -  Properties
    fileprivate var contact:ContactResource?
    
    var delegate:ContactTableCellDelegate?
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func configureCell(_ currContact:ContactResource){
        self.contact = currContact
        
        self.contactName.text = currContact.fullname
        self.contactPhone.text = currContact.phone
        self.contactImage.image = currContact.image
    }
}

//MARK: - Actions
extension ContactTableViewCell {

    @IBAction func sendTextMessage(_ sender: Any) {
        if contact != nil {
            guard let primaryPhone:String = contact!.phone else {
                print("no phone found")
                return
            }
            
            let subject             = ""
            let body:String         = ""
            let recipients:[String] = [primaryPhone]
            let messsageToSend:MessageResource = MessageResource(recipients: recipients,
                                                                 body: body,
                                                                 subject: subject,
                                                                 type: MessageResourceType.text)
            
            delegate?.sendTextMessage(message: messsageToSend)
        }
    }
    
    @IBAction func sendEmailMessage(_ sender: Any) {
        if contact != nil {
            guard let primaryEmail:String = contact!.email else {
                print("no email found")
                return
            }
            
            let subject             = ""
            let body:String         = ""
            let recipients:[String] = [primaryEmail]
            let messsageToSend:MessageResource = MessageResource(recipients: recipients,
                                                                 body: body,
                                                                 subject: subject,
                                                                 type: MessageResourceType.email)
            
            delegate?.sendEmailMessage(message: messsageToSend)
        }
    }
}

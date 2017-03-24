//
//  ListContactsTableViewController.swift
//  contactList
//
//  Created by Luis Castillo on 12/31/15.
//  Copyright © 2015 Luis Castillo. All rights reserved.
//

import UIKit

//for contacts
import Contacts
import ContactsUI


//for email and text message
import MessageUI

class ListContactsTableViewController: UITableViewController, ContactTableCellDelegate
{
    //UI Properties
    @IBOutlet weak var totalContacts: UIBarButtonItem!
    
    //Contacts
    fileprivate var contactsList:[ContactResource] = []
    
    //MARK: - Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

        ContactModel.shared.requestAuthorization { (success:Bool) in
            if success {
                print("permission granted")
            }
            else {
                print("permission unknown")
            }
        }
    }//eom
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        ContactModel.shared.fetchAllContacts { (contacts:[CNContact]) in
            DispatchQueue.main.async {
                self.updateContactView(contacts)
            }
        }
    }//eom
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
    }//eom
    
    //MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//eom
    
    // MARK: - Tableview Cell Delegates
    func sendTextMessage(message: MessageResource) {
        showTextMessagePicker(message)
    }
    
    func sendEmailMessage(message: MessageResource) {
        showEmailPicker(message)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let index:Int = Int((indexPath as NSIndexPath).row)
        self.presentAContact(index)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:ContactTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactTableViewCell)!
        
        let currIndex:Int = Int((indexPath as NSIndexPath).row)
        
        let currContact:ContactResource = contactsList[currIndex]
        cell.configureCell(currContact)
        cell.delegate = self
        
        return cell
    }//eom
}

//MARK: - Update / Sort Contacts
extension ListContactsTableViewController {
    func updateContactView(_ results: [CNContact])
    {
        let sortedContacts:[CNContact] = ContactModel.shared.sortByName(results)
        contactsList = parseContactsToResource(sortedContacts)
        
        tableView .reloadData()
        
        totalContacts.title = "\(contactsList.count) contacts"
    }//eom
}

//MARK: - Present Current Contact
extension ListContactsTableViewController:CNContactViewControllerDelegate {
    func presentAContact(_ index:Int)
    {
        let currContact:ContactResource = contactsList[index]
        
        if let currContactID:String = currContact.id {
            ContactModel.shared.fetchContactWithID(currContactID, completion: { (contact:CNContact?) in
                if let contactFound:CNContact = contact {
                    DispatchQueue.main.async {
                        self.presentContact(contactFound)
                    }
                }
            })
        }
    }//eom
    
    fileprivate func presentContact(_ contact:CNContact){
        let existingContactVC:CNContactViewController = CNContactViewController(for: contact)
        existingContactVC.delegate = self
        existingContactVC.contactStore = ContactModel.shared.store

        self.navigationController?.pushViewController(existingContactVC, animated: true)
    }
}

//MARK: - Text Message
extension ListContactsTableViewController:MFMessageComposeViewControllerDelegate {
    func showTextMessagePicker(_ message:MessageResource)
    {
        if( MFMessageComposeViewController .canSendText())
        {
            let textMessagePicker = MFMessageComposeViewController()
            textMessagePicker.messageComposeDelegate = self
            
            //Body
            textMessagePicker.body = message.body
            
            //recipients
            textMessagePicker.recipients = message.recipients
            
            self.present(textMessagePicker, animated: true, completion:
                { () -> Void in
                    
            })
        }
        else
        {
            print("Your Device is not able to send Text message")
        }
    }//eom
    
    //MARK:  Text Message Delegates
    func messageComposeViewController(_ controller: MFMessageComposeViewController,
                                      didFinishWith result: MessageComposeResult)
    {
        switch(result)
        {
            case MessageComposeResult.cancelled:
                print("Message Cancelled")
                break
            case MessageComposeResult.failed:
                print("Message Failed")
                break
            case MessageComposeResult.sent:
                print("Message Sent")
                break
        }
        
        self.dismiss(animated: true) { () -> Void in
            
        }
    }//eom
}

//MARK: - Email
extension ListContactsTableViewController:MFMailComposeViewControllerDelegate  {
    
    func showEmailPicker(_ message:MessageResource)
    {
        if( MFMailComposeViewController .canSendMail() )
        {
            let mailPicker = MFMailComposeViewController()
            mailPicker.mailComposeDelegate = self
            
            //subject
            mailPicker .setSubject(message.subject)
            
            //recipients
            let sendRecipients = message.recipients
            mailPicker .setToRecipients(sendRecipients)
            
            //attachments
            //            let attachmentData = NSData()
            //            let mimeType:String = String()
            //            let fileName:String = String()
            //            mailPicker .addAttachmentData(attachmentData, mimeType: mimeType, fileName: fileName)
            
            //body
            let bodyMessage = message.body
            mailPicker .setMessageBody(bodyMessage, isHTML: false)
            
            self.present(mailPicker, animated: true, completion:
            { () -> Void in
            
            })
            
        }
        else
        {
            print("Your Device is not able to send Emails")
        }
    }//eom
    
    //MARK: Email Delegates
    func mailComposeController(_ controller: MFMailComposeViewController,
        didFinishWith result: MFMailComposeResult,
        error: Error?)
    {
        switch(result)
        {
            case MFMailComposeResult.cancelled:
                print("Email Cancelled")
                break
            case MFMailComposeResult.failed:
                print("Email Failed")
                break
            case MFMailComposeResult.saved:
                print("Email Saved")
                break
            case MFMailComposeResult.sent:
                print("Email Sent")
                break
        }
        
        self.dismiss(animated: true) { () -> Void in
            
        }//
    }
}

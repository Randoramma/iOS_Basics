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



class ListContactsTableViewController: UITableViewController, CNContactViewControllerDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate
{
    
    //UI Properties
    @IBOutlet weak var totalContacts: UIBarButtonItem!
    
    //Contacts
    var contactsList:NSArray = NSArray()
    let contactStore = CNContactStore()
    
    
    //MARK: - View Loading
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.getAllContactsFromAllContainers()
    }//eom
    
    override func viewDidAppear(animated: Bool)
    {
        
        
    }//eom
    
    //MARK: - Load Contacts
    func getAllContactsFromAllContainers()
    {
        // specific keys
        let contactKeysSearching = [CNContactGivenNameKey,
                                    CNContactFamilyNameKey,
                                    CNContactBirthdayKey,
                                    CNContactPhoneNumbersKey,
                                    CNContactEmailAddressesKey,
                                    CNContactOrganizationNameKey,
                                    CNContactPostalAddressesKey,
                                    CNContactImageDataKey
                                    ]
        
        //get all containers
        var AllContainers:[CNContainer] = []
        
        do
        {
            AllContainers =  try contactStore.containersMatchingPredicate(nil)
        }
        catch
        {
            print("error fetching all containers")
        }
        
        var results:[CNContact] = []
        
        //iter
        for currContainer in AllContainers
        {
            let fetchPredicate = CNContact.predicateForContactsInContainerWithIdentifier(currContainer.identifier)
            
            do
            {
                let containerResults = try contactStore.unifiedContactsMatchingPredicate(fetchPredicate, keysToFetch: contactKeysSearching)
                results.appendContentsOf(containerResults)
            }
            catch
            {
                print("error fetching results for container '\(fetchPredicate)'")
            }
        
        }//eofl
        
        self.updateContactView(results)
        
        
    }//eom
    
    //MARK: Update / Sort Contacts
    func updateContactView(results: AnyObject)
    {
        
        contactsList = NSArray(array: results as! [AnyObject])
        
        //sorting data
        
        let sortedList =
        contactsList.sort { (first, second) -> Bool in
            
            guard let one:CNContact = first as? CNContact else { print("first not a contact") ; return false }
            guard let two:CNContact = second as? CNContact else { print("second not a contact") ; return false }
            
            var oneName:String = ""
            var twoName:String = ""
            
            //first
            if one.isKeyAvailable(CNContactGivenNameKey)
            {
                oneName = one.givenName
            }
            
            if oneName.characters.count ==  0
            {
                if one.isKeyAvailable(CNContactOrganizationNameKey)
                {
                    oneName = one.organizationName
                }
            }
            
            if oneName.characters.count ==  0
            {
                if one.isKeyAvailable(CNContactFamilyNameKey)
                {
                    oneName = one.familyName
                }
                
            }
            
            //second
            if two.isKeyAvailable(CNContactGivenNameKey)
            {
                twoName = two.givenName
            }
            
            if twoName.characters.count ==  0
            {
                if two.isKeyAvailable(CNContactOrganizationNameKey)
                {
                    twoName = two.organizationName
                }
            }
            
            if twoName.characters.count ==  0
            {
                if two.isKeyAvailable(CNContactFamilyNameKey)
                {
                    twoName = two.familyName
                }
                
            }
          
            
           return oneName.localizedCaseInsensitiveCompare(twoName) == NSComparisonResult.OrderedAscending
        }//eo-sorting
        
        
        contactsList = sortedList
        //self.printContacts()
        
        self.tableView .reloadData()
        
        //update total contacts
        totalContacts.title = "\(contactsList.count) contacts"
        
    }//eom
   
    
    //MARK: Present Current Contact
    func presentAContact(index:Int)
    {
        if let currContact = contactsList .objectAtIndex(index) as? CNContact
        {
            let currContactID = currContact.identifier
            let IDKeysSearching = [CNContactViewController.descriptorForRequiredKeys()]
            
            do
            {
                let contact = try contactStore.unifiedContactWithIdentifier(currContactID, keysToFetch: IDKeysSearching)
                
                let existingContactVC:CNContactViewController = CNContactViewController(forContact: contact)
                existingContactVC.delegate = self
                existingContactVC.contactStore = contactStore
                
                self.navigationController?.pushViewController(existingContactVC, animated: true)
                
            }
            catch
            {
                print("un-able to present curr contact")
            }
        }//eo-curr contact
        
    }//eom
   
    //MARK: Contact Authorization
    
    func checkContactAuthorization ()
    {
        
        //        CNAuthorizationStatus.Authorized
        //        CNAuthorizationStatus.NotDetermined
        //        CNAuthorizationStatus.Denied
        //        CNAuthorizationStatus.Restricted
        
    }//eom
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }//eom

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsList.count
    }//eom

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let index:Int = Int(indexPath.row)
        self.presentAContact(index)
        
    }//eom
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:ContactTableViewCell = (tableView.dequeueReusableCellWithIdentifier("contactCell", forIndexPath: indexPath) as? ContactTableViewCell)!
        
        let index:Int = Int(indexPath.row)
        //print("\n\(index)")//testing
        if let currContact = contactsList .objectAtIndex(index) as? CNContact
        {
            //contact name
            var fullname:NSString = ""
            if(currContact.isKeyAvailable(CNContactGivenNameKey))
            {
                fullname = currContact.givenName
            }
            
            if fullname.length == 0
            {
                if(currContact.isKeyAvailable(CNContactOrganizationNameKey))
                {
                    fullname = currContact.organizationName
                }
            }
            else
            {
                if(currContact.isKeyAvailable(CNContactFamilyNameKey))
                {
                    fullname = fullname .stringByAppendingString(" \(currContact.familyName)")
                }
            }
            
           // print("\(fullname)")//testing
            
            cell.contactName.text = fullname as String
            
            //contact number
            if (currContact.isKeyAvailable(CNContactPhoneNumbersKey))
            {
                let numbers:[CNLabeledValue]        = currContact.phoneNumbers
                if numbers.count > 0
                {
                    let firstNumLabel:CNLabeledValue    = numbers[0]
                    if let firstNum  = firstNumLabel.value as? CNPhoneNumber
                    {
                        let phoneNumber = firstNum.stringValue
                        cell.contactPhone.text = phoneNumber
                        
                        //print("\(phoneNumber)")//testing
                    }
                }
            }//eo-phone numbers
            
            //contact image
            if (currContact.isKeyAvailable(CNContactImageDataKey))
            {
                if let contactImageData = currContact.imageData
                {
                    let currContactImage = UIImage(data: contactImageData)
                    cell.contactImage.image = currContactImage
                }//eo-image
            }
            
            //updating actions for contact
            
            cell.contactTextMsgButton.tag   = index
            cell.contactEmailButton.tag     = index

            cell.contactTextMsgButton.addTarget(self, action: #selector(ListContactsTableViewController.sendCurrContactAnTextMessage(_:)), forControlEvents: UIControlEvents.TouchDown)
            
            cell.contactEmailButton.addTarget(self, action: #selector(ListContactsTableViewController.sendCurrContactAnEmail(_:)), forControlEvents: UIControlEvents.TouchDown)
            
            
        }//eo-valid contact
        
        return cell
    }//eom
    

    //MARK: - Text Message
    func sendCurrContactAnTextMessage(sender:UIButton)
    {
        let index = sender.tag
        if let currContact = contactsList[index] as? CNContact
        {
            if (currContact.isKeyAvailable(CNContactPhoneNumbersKey))
            {
                let phoneNumbers = currContact.phoneNumbers
                if phoneNumbers.count > 0
                {
                    let firstNumLabel = phoneNumbers[0]
                    let firstNumber = firstNumLabel.value as? CNPhoneNumber
                    if let phoneNumber = firstNumber?.stringValue
                    {
                        self.showTextMessagePicker(phoneNumber)
                    }
                }//eo-phone numbers
                else
                {
                    print("user does NOT have a phone number")
                }
            }//eo-key requested
        }//eo-curr contact
    }//eom
    
    func showTextMessagePicker(phoneNumberSending:String)
    {
        if( MFMessageComposeViewController .canSendText())
        {
            let textMessagePicker = MFMessageComposeViewController()
            textMessagePicker.messageComposeDelegate = self
            
            //Body
            textMessagePicker.body = "Hello From App"
            
            //recipients
            textMessagePicker.recipients = [phoneNumberSending]
            
            self.presentViewController(textMessagePicker, animated: true, completion:
            { () -> Void in
                
            })
        }
        else
        {
            print("Your Device is not able to send Text Messages")
        }
    }//eom
    
    //MARK:  Text Message Delegates
    
    func messageComposeViewController(controller: MFMessageComposeViewController,
        didFinishWithResult result: MessageComposeResult)
    {
        switch(result)
        {
        case MessageComposeResultCancelled:
            print("Message Cancelled")
            break
        case MessageComposeResultFailed:
            print("Message Failed")
            break
        case MessageComposeResultSent:
            print("Message Sent")
            break
        default:
            break
        }
        
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }//
        
    }//eom
    
    
    //MARK: - Email
    func sendCurrContactAnEmail(sender: UIButton)
    {
        let index = sender.tag
        if let currContact = contactsList[index] as? CNContact
        {
            if(currContact.isKeyAvailable(CNContactEmailAddressesKey))
            {
                let contactEmails = currContact.emailAddresses
                if contactEmails.count > 0
                {
                    let contactEmailLabel   = contactEmails[0]
                    let contactEmail        = contactEmailLabel.value
                    if let email = contactEmail as? String
                    {
                        self.showEmailPicker(email)
                    }
                }
                else
                {
                    print("user does NOT have an email address")
                }
            }//eo-email was request
        }//eo-curr contact
    }//eom
    
    
    func showEmailPicker(emailAddressSending:String)
    {
        if( MFMailComposeViewController .canSendMail() )
        {
            let mailPicker = MFMailComposeViewController()
            mailPicker.mailComposeDelegate = self
            
            //subject
            mailPicker .setSubject("Subject goes here")
            
            //recipients
            let sendRecipients = [emailAddressSending]
            mailPicker .setToRecipients(sendRecipients)
            
            //attachments
            //            let attachmentData = NSData()
            //            let mimeType:String = String()
            //            let fileName:String = String()
            //            mailPicker .addAttachmentData(attachmentData, mimeType: mimeType, fileName: fileName)
            
            //body
            let bodyMessage = "Dear Turtle"
            mailPicker .setMessageBody(bodyMessage, isHTML: false)
            
            self.presentViewController(mailPicker, animated: true, completion:
            { () -> Void in
            
            })
            
        }
        else
        {
            print("Your Device is not able to send Emails")
        }
        
    }//eom
    
    //MARK: Email Delegates
    func mailComposeController(controller: MFMailComposeViewController,
        didFinishWithResult result: MFMailComposeResult,
        error: NSError?)
    {
        switch(result)
        {
        case MFMailComposeResultCancelled:
            print("Email Cancelled")
            break
        case MFMailComposeResultFailed:
            print("Email Failed")
            break
        case MFMailComposeResultSaved:
            print("Email Saved")
            break
        case MFMailComposeResultSent:
            print("Email Sent")
            break
        default:
            break
        }
        
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }//
        
    }//eom
    
    //MARK: - Debug
//    func printContacts()
//    {
//        for (var iter = 0; iter < contactsList.count ; iter += 1)
//        {
//            print("\nContact#\(iter)")
//            
//            let currContact = contactsList .objectAtIndex(iter)
//            if currContact.isKeyAvailable(CNContactGivenNameKey)
//            {
//                print("GivenName: \(currContact.givenName)")
//            }
//            if currContact.isKeyAvailable(CNContactFamilyNameKey)
//            {
//                print("familyName: \(currContact.familyName)")
//            }
//            if currContact.isKeyAvailable(CNContactOrganizationNameKey)
//            {
//                print("organizationName: \(currContact.organizationName)")
//            }
//            
//        }//eofl
//        
//        print("- - - - - - - - - - - - - - - - - - - - - - - - - - - ")
//        
//    }//eom
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
    }//eom

    
  
    
    //MARK: - Memory
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//eom

}

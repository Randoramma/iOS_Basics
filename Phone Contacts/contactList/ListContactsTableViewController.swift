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

        self.requestContactPermission()
    }//eom
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getAllContactsFromAllContainers()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        
        
    }//eom
    
    
    
    //MARK: - Load Contacts
    func requestContactPermission(){
        contactStore.requestAccess(for: CNEntityType.contacts) { (success:Bool, error:Error?) in
            if let errorOccurred:Error = error{
                print(errorOccurred.localizedDescription)
            }else {
                if success {
                    print("permission granted")
                }
                else {
                    print("permission unknown")
                }
            }
            
            
        }
    }
    
    
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
            AllContainers =  try contactStore.containers(matching: nil)
        }
        catch
        {
            print("error fetching all containers")
        }
        
        var results:[CNContact] = []
        
        //iter
        for currContainer in AllContainers
        {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: currContainer.identifier)
            
            do
            {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: contactKeysSearching as [CNKeyDescriptor])
                results.append(contentsOf: containerResults)
            }
            catch
            {
                print("error fetching results for container '\(fetchPredicate)'")
            }
        
        }//eofl
        
        self.updateContactView(results as AnyObject)
        
        
    }//eom
    
    //MARK: Update / Sort Contacts
    func updateContactView(_ results: AnyObject)
    {
        
        contactsList = NSArray(array: results as! [AnyObject])
        
        //sorting data
        
        let sortedList =
        contactsList.sorted { (first, second) -> Bool in
            
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
          
            
           return oneName.localizedCaseInsensitiveCompare(twoName) == ComparisonResult.orderedAscending
        }//eo-sorting
        
        
        contactsList = sortedList as NSArray
        self.printContacts()
        
        self.tableView .reloadData()
        
        //update total contacts
        totalContacts.title = "\(contactsList.count) contacts"
        
    }//eom
   
    
    //MARK: Present Current Contact
    func presentAContact(_ index:Int)
    {
        if let currContact = contactsList .object(at: index) as? CNContact
        {
            let currContactID = currContact.identifier
            let IDKeysSearching = [CNContactViewController.descriptorForRequiredKeys()]
            
            do
            {
                let contact = try contactStore.unifiedContact(withIdentifier: currContactID, keysToFetch: IDKeysSearching)
                
                let existingContactVC:CNContactViewController = CNContactViewController(for: contact)
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }//eom

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsList.count
    }//eom

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let index:Int = Int((indexPath as NSIndexPath).row)
        self.presentAContact(index)
        
    }//eom
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:ContactTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactTableViewCell)!
        
        let index:Int = Int((indexPath as NSIndexPath).row)
        //print("\n\(index)")//testing
        if let currContact = contactsList .object(at: index) as? CNContact
        {
            //contact name
            var fullname:NSString = ""
            if(currContact.isKeyAvailable(CNContactGivenNameKey))
            {
                fullname = currContact.givenName as NSString
            }
            
            if fullname.length == 0
            {
                if(currContact.isKeyAvailable(CNContactOrganizationNameKey))
                {
                    fullname = currContact.organizationName as NSString
                }
            }
            else
            {
                if(currContact.isKeyAvailable(CNContactFamilyNameKey))
                {
                    fullname = fullname .appending(" \(currContact.familyName)") as NSString
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
                    let firstNum:CNPhoneNumber  = firstNumLabel.value
                    let phoneNumber = firstNum.stringValue
                    cell.contactPhone.text = phoneNumber
                    
                    //print("\(phoneNumber)")//testing
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

            cell.contactTextMsgButton.addTarget(self, action: #selector(ListContactsTableViewController.sendCurrContactAnTextMessage(_:)), for: UIControlEvents.touchDown)
            
            cell.contactEmailButton.addTarget(self, action: #selector(ListContactsTableViewController.sendCurrContactAnEmail(_:)), for: UIControlEvents.touchDown)
            
            
        }//eo-valid contact
        
        return cell
    }//eom
    

    //MARK: - Text Message
    func sendCurrContactAnTextMessage(_ sender:UIButton)
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
                    let firstNumber:CNPhoneNumber = firstNumLabel.value as CNPhoneNumber
                    let phoneNumber = firstNumber.stringValue
                    
                    self.showTextMessagePicker(phoneNumber)
                }//eo-phone numbers
                else
                {
                    print("user does NOT have a phone number")
                }
            }//eo-key requested
        }//eo-curr contact
    }//eom
    
    func showTextMessagePicker(_ phoneNumberSending:String)
    {
        if( MFMessageComposeViewController .canSendText())
        {
            let textMessagePicker = MFMessageComposeViewController()
            textMessagePicker.messageComposeDelegate = self
            
            //Body
            textMessagePicker.body = "Hello From App"
            
            //recipients
            textMessagePicker.recipients = [phoneNumberSending]
            
            self.present(textMessagePicker, animated: true, completion:
            { () -> Void in
                
            })
        }
        else
        {
            print("Your Device is not able to send Text Messages")
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
            
        }//
        
    }//eom
    
    
    //MARK: - Email
    func sendCurrContactAnEmail(_ sender: UIButton)
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
                    let email:String        = contactEmail as String
                    
                    self.showEmailPicker(email)
                }
                else
                {
                    print("user does NOT have an email address")
                }
            }//eo-email was request
        }//eo-curr contact
    }//eom
    
    
    func showEmailPicker(_ emailAddressSending:String)
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
        
    }//eom
    
    //MARK: - Debug
    func printContacts()
    {
        for iter in 0..<contactsList.count
        {
            print("\nContact#\(iter)")
            
            let currContact = contactsList .object(at: iter)
            print(currContact)
//            
//            if (currContact as AnyObject).isKeyAvailable(CNContactGivenNameKey)
//            {
//                print("GivenName: \((currContact as AnyObject).givenName)")
//            }
//            if (currContact as AnyObject).isKeyAvailable(CNContactFamilyNameKey)
//            {
//                print("familyName: \(currContact.familyName)")
//            }
//            if currContact.isKeyAvailable(CNContactOrganizationNameKey)
//            {
//                print("organizationName: \(currContact.organizationName)")
//            }
            
        }//eofl
        
        print("- - - - - - - - - - - - - - - - - - - - - - - - - - - ")
        
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

}

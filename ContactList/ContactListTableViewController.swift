//
//  ContactListTableViewController.swift
//  ContactList
//
//  Created by Patrick Hayes on 11/17/17.
//  Copyright © 2017 Patrick Hayes. All rights reserved.
//

import UIKit
import CoreData

class ContactListTableViewController: UITableViewController, AddContactDelegate {

    var contacts = [Contact]()
    var managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contact List"
        fetchAllContacts()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Required for table views++++++++++++++++++++++++++++++++++++
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        
        let fullname = "\(contacts[indexPath.row].firstName!) \(contacts[indexPath.row].lastName!)"
        let number = contacts[indexPath.row].phoneNumber
        
        cell.textLabel?.text = fullname
        cell.detailTextLabel?.text = number
        return cell
    }
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    //Grabbing contacts from coredata and adding to array
    func fetchAllContacts(){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        do {
            let result = try managedObjectContext.fetch(request)
            contacts = result as! [Contact]
        } catch {
            print("\(error)")
        }
        
    }
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    //Prepare, MUST BE INCLUDED IN ORDER TO SEND TO INFO TO NEW SEGUE AND HAVE NAV BAR WORK IN NEW SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "ViewDetails" {
            
            let navigationController = segue.destination as! UINavigationController
            let contactDetails = navigationController.topViewController as! ContactDetailsTableViewController
            
            contactDetails.contact = sender as? Contact
        }
         else if segue.identifier == "AddContactSegue" && sender is UIBarButtonItem ? true : false {
            let navigationController = segue.destination as! UINavigationController
            let addContact = navigationController.topViewController as! AddContactTableViewController
            addContact.delegate = self
        }
//        else if segue.identifier == "AddContactSegue" && sender is UIBarButtonItem ? true : false{
            else {
            
            let navigationController = segue.destination as! UINavigationController
            let editContact = navigationController.topViewController as! AddContactTableViewController
            editContact.delegate = self
            
            
            if let indexPath = sender as? NSIndexPath{

                let contact = contacts[indexPath.row]
                print("This is the contact: \(contact)")
                
                editContact.firstName = contact.firstName
                editContact.lastName = contact.lastName
                editContact.phoneNumber = contact.phoneNumber
                editContact.indexPath = indexPath

                print("Bye")
            }
        }
//        else if segue.identifier == "ViewDetails" {
//
//            let navigationController = segue.destination as! UINavigationController
//            let contactDetails = navigationController.topViewController as! ContactDetailsTableViewController
//
//            contactDetails.contact = sender as? Contact
//        }
    }
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    
    //Adding Contact to coredata
    
    func contactSaved(by controller: AddContactTableViewController, with text: [String], at indexPath: NSIndexPath?) {
        if let ip = indexPath {
            let contact = self.contacts[ip.row]
            contact.firstName = text[0]
            contact.lastName = text[1]
            contact.phoneNumber = text[2]
        } else {

            let contact = NSEntityDescription.insertNewObject(forEntityName: "Contact", into: managedObjectContext) as! Contact
            contact.firstName = text[0]
            contact.lastName = text[1]
            contact.phoneNumber = text[2]
            contacts.append(contact)

        }

        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }

        tableView.reloadData()

        dismiss(animated: true, completion: nil)
    }
    //++++++++++++++++++++++++++++++++++++++++++++++
    
    //selecting a cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print("Cell Selected")
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let viewAction = UIAlertAction(title: "View", style: .default) {
            _ in
            self.performSegue(withIdentifier: "ViewDetails", sender: self.contacts[indexPath.row])
            print("This is the view sender:  \(self.contacts[indexPath.row])")
        }
        let editAction = UIAlertAction(title: "Edit", style: .default) {
            _ in
            self.performSegue(withIdentifier: "AddContactSegue", sender: indexPath)

        }
        let deleteAction = UIAlertAction(title: "Delete", style: .default) {
            _ in
            
            let c = self.contacts[indexPath.row]
            print("this is the contact \(c)")
            self.managedObjectContext.delete(c)
            do {
                try self.managedObjectContext.save()
            } catch {
                print("\(error)")
            }
            self.contacts.remove(at: indexPath.row)
            tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            UIAlertAction -> Void in
        }

        alert.addAction(viewAction)
        alert.addAction(editAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
        
    }
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

}

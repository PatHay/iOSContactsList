//
//  AddContactTableViewController.swift
//  ContactList
//
//  Created by Patrick Hayes on 11/17/17.
//  Copyright © 2017 Patrick Hayes. All rights reserved.
//

import UIKit

class AddContactTableViewController: UITableViewController {
    
    var contact: Contact!
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
    
    var delegate: AddContactDelegate?
    var indexPath: NSIndexPath?
    
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var phoneNumberText: UITextField!
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let firstName = firstNameText.text!
        let lastName = lastNameText.text!
        let phoneNumber = phoneNumberText.text!
        print("I pressed save")
        delegate?.contactSaved(by: self, with: [firstName, lastName, phoneNumber], at: indexPath)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if indexPath == nil{
            self.title = "New Contact"
        } else {
            self.title = "Edit Contact"
            firstNameText.text = firstName
            lastNameText.text = lastName
            phoneNumberText.text = phoneNumber
//            print("This is the index \(contact.indexPath!)")
        }
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }


}

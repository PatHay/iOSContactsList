//
//  ContactDetailsTableViewController.swift
//  ContactList
//
//  Created by Patrick Hayes on 11/17/17.
//  Copyright © 2017 Patrick Hayes. All rights reserved.
//

import UIKit

class ContactDetailsTableViewController: UITableViewController {
    
    var contact: Contact!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = contact.firstName!
        fullNameLabel.text = "\(contact.firstName!) \(contact.lastName!)"
        phoneNumberLabel.text = "\(contact.phoneNumber!)"

    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

}

//
//  AddContactDelegate.swift
//  ContactList
//
//  Created by Patrick Hayes on 11/17/17.
//  Copyright © 2017 Patrick Hayes. All rights reserved.
//

import UIKit

protocol AddContactDelegate: class {
    
    func contactSaved(by controller: AddContactTableViewController, with text: [String], at indexPath: NSIndexPath?)
//    func cancelButtonPressed(by controller: AddContactTableViewController)
    
}

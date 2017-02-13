//
//  UserListTableViewController.swift
//  SwapCard Project
//
//  Created by Aditya Vikram Godawat on 12/02/17.
//  Copyright © 2017 Aditya Vikram Godawat. All rights reserved.
//

import UIKit

class UserListTableViewController: UITableViewController {

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
    
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Users"
        self.navigationController?.navigationBar.isHidden = false        
    }
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return _USERS.count
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell = UITableViewCell(style: .subtitle, reuseIdentifier: "")

        let aUser = _USERS[indexPath.row]

        aCell.imageView?.image = aUser.picture
        
        aCell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        aCell.detailTextLabel?.font = UIFont.systemFont(ofSize: 18)
        
        aCell.textLabel?.text = aUser.email
        aCell.detailTextLabel?.text = aUser.firstName+" "+aUser.lastName
        
        return aCell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(_USERS[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        
        let aVC = UserDetailsViewController()
        aVC.user = _USERS[indexPath.row]
        self.navigationController?.pushViewController(aVC, animated: true)
    }
}

//
//  ViewController.swift
//  ContactsApp
//
//  Created by hardik aghera on 10/03/18.
//  Copyright © 2018 hardik aghera. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let cellId = "cellId"
    let names = ["Amy","Bella","Carmella","Paul","Haris","Dave","Jack"]
    let cNames = ["Carl","Cameron","Chris","Christina","Cathy"]
    let twoDimentionalArray = [
        ["Amy","Bella","Carmella","Paul","Haris","Dave","Jack"],["Carl","Cameron","Chris","Christina","Cathy"],["Dan","Daniel"]
    ]
    var showIndexPath = false
    
    @objc func handleShowIndexPath() {
        print("Attempting to reload animation of indexPath...")
        // build all the indexPath we want to reload
        var indexPathtoReload = [IndexPath]()
        for section in twoDimentionalArray.indices {
            for row in twoDimentionalArray[section].indices{
                print(section,row)
                let indexPath = IndexPath(row:row, section:section)
                indexPathtoReload.append(indexPath)
            }
        }
        showIndexPath = !showIndexPath
        let animationStyle = showIndexPath ? UITableViewRowAnimation.right : .left
        
        tableView.reloadRows(at: indexPathtoReload, with:animationStyle)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show indexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Header"
        label.backgroundColor = UIColor.orange
        return label
    }
    
   override func numberOfSections(in tableView: UITableView) -> Int {
    
        return twoDimentionalArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  twoDimentionalArray[section].count
//        if section == 0 {
//            return names.count
//        }
//        return cNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
      //  let name = self.names[indexPath.row]
//        let name = indexPath.section == 0 ? names[indexPath.row] : cNames[indexPath.row]
        let name = twoDimentionalArray[indexPath.section][indexPath.row]
        cell.textLabel?.text = name
        if showIndexPath {
          cell.textLabel?.text = "\(name) Section:\(indexPath.section) Row:\(indexPath.row)"
        }
        return cell
    }


}


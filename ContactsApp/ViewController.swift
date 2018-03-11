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
    func somemethod(cell: UITableViewCell) {
      let indexPathTapped = tableView.indexPath(for: cell)
      let contact = twoDimentionalArray[indexPathTapped!.section].names[indexPathTapped!.row]
        print(contact)
        
        let hasFavorited = contact.hasFavorited
        twoDimentionalArray[indexPathTapped!.section].names[indexPathTapped!.row].hasFavorited = !hasFavorited
        
     //   tableView.reloadRows(at: [indexPathTapped!], with: .fade)
        
        cell.accessoryView?.tintColor = hasFavorited ? .lightGray : .red
    }
    
    var twoDimentionalArray = [
        ExpandableNames(isExpanded: true, names: ["Amy","Bella","Carmella","Paul","Haris","Dave","Jack"].map{Contact(name: $0,hasFavorited: false)}),
        ExpandableNames(isExpanded: true, names: ["Carl","Cameron","Chris","Christina","Cathy"].map{Contact(name: $0,hasFavorited: false)}),
        ExpandableNames(isExpanded: true, names: [ Contact(name: "Patrick", hasFavorited: false)])
    ]
    var showIndexPath = false
    
    @objc func handleShowIndexPath() {
       
    //    print("Attempting to reload animation of indexPath...")
        // build all the indexPath we want to reload
        var indexPathtoReload = [IndexPath]()
        for section in twoDimentionalArray.indices {
            for row in twoDimentionalArray[section].names.indices{
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
        
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section
        return button
    }
    
    @objc func handleExpandClose(button: UIButton){
    print("Trying to expand and Close Section...")
        print(button.tag)
        let section = button.tag
        // Close the section by deleting rows in the table
        var indexPaths = [IndexPath]()
        for row in twoDimentionalArray[section].names.indices {
            print(0,row)
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        let isExpanded = twoDimentionalArray[section].isExpanded
        twoDimentionalArray[section].isExpanded = !isExpanded
        button.setTitle(isExpanded ? "Open": "Close", for: .normal)
        
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        }else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
   override func numberOfSections(in tableView: UITableView) -> Int {
    
        return twoDimentionalArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimentionalArray[section].isExpanded {
            return 0
        }
        return  twoDimentionalArray[section].names.count

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ContactCell
        cell.link = self
        let contact = twoDimentionalArray[indexPath.section].names[indexPath.row]
        cell.textLabel?.text = contact.name
        cell.accessoryView?.tintColor = contact.hasFavorited ? UIColor.red: .lightGray
        if showIndexPath {
          cell.textLabel?.text = "\(contact.name) Section:\(indexPath.section) Row:\(indexPath.row)"
        }
        return cell
    }


}


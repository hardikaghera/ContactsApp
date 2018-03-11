//
//  ContactCell.swift
//  ContactsApp
//
//  Created by hardik aghera on 11/03/18.
//  Copyright © 2018 hardik aghera. All rights reserved.
//

import UIKit

class ContactCell : UITableViewCell {
    
    var link: ViewController?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
     //   backgroundColor = .red
        let starButton = UIButton(type: .system)
        starButton.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        starButton.tintColor = .red
        accessoryView = starButton
        starButton.addTarget(self, action: #selector(handleMarkasFavorite), for: .touchUpInside)
        
        
    }
    
    @objc func handleMarkasFavorite() {
        link?.somemethod(cell: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

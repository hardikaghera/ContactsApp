//
//  ExpandableNames.swift
//  ContactsApp
//
//  Created by hardik aghera on 10/03/18.
//  Copyright © 2018 hardik aghera. All rights reserved.
//

import Foundation

struct ExpandableNames {
    
    var isExpanded: Bool
    var names: [Contact]
}

struct Contact {
    let name: String
    var hasFavorited: Bool
}

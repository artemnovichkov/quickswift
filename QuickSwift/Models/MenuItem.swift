//
//  MenuItem.swift
//  QuickSwift
//
//  Created by Artem on 9/23/15.
//  Copyright © 2015 Rosberry. All rights reserved.
//

import Foundation

class MenuItem {
    var title: String
    var subtitle: String?
    var iconName: String?
    var tapHandlerName: String?
    
    init(title: String) {
        self.title = title
    }
}
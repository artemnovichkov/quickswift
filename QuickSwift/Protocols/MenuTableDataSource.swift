//
//  MenuTableDataSource.swift
//  QuickSwift
//
//  Created by Artem on 9/23/15.
//  Copyright © 2015 Rosberry. All rights reserved.
//

import UIKit

protocol MenuTableDataSource: UITableViewDataSource, UITableViewDelegate {
    func setMenuItems(menuItems: [MenuItem])
}
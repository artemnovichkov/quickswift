//
//  MenuTableFakeDataSource.swift
//  QuickSwift
//
//  Created by Artem on 9/24/15.
//  Copyright © 2015 Rosberry. All rights reserved.
//

import Foundation
import UIKit

class MenuTableFakeDataSource: NSObject, MenuTableDataSource {
    // MARK: - MenuTableDataSource
    func setMenuItems(menuItems: [MenuItem]) {
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

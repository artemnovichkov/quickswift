//
//  MenuTableDefaultDataSource.swift
//  QuickSwift
//
//  Created by Artem on 9/23/15.
//  Copyright © 2015 Rosberry. All rights reserved.
//

import UIKit

let MenuTableDataSourceDidSelectItemNotification = "MenuTableDataSourceDidSelectItemNotification"

class MenuTableDefaultDataSource: NSObject, MenuTableDataSource {
    var menuItems: [MenuItem]?
    
    //MARK: - MenuTableDataSource
    func setMenuItems(menuItems: [MenuItem]) {
        self.menuItems = menuItems
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems!.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: nil)
        let menuItem = menuItems?[indexPath.row]
        cell.textLabel!.text = menuItem?.title
        cell.detailTextLabel!.text = menuItem?.subtitle
        if let iconName = menuItem?.iconName {
            cell.imageView?.image = UIImage(named: iconName)
        }
        cell.accessoryType = .DisclosureIndicator
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let menuItem = menuItems?[indexPath.row]
        let notification = NSNotification(name: MenuTableDataSourceDidSelectItemNotification, object: menuItem)
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
}
//
//  MenuViewController.swift
//  QuickSwift
//
//  Created by Artem on 9/24/15.
//  Copyright © 2015 Rosberry. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var dataSource: MenuTableDataSource?
    var tapHandlerBuilder: MenuItemTapHandlerBuilder?
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "App Menu"
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "didSelectMenuItemNotification:",
            name: MenuTableDataSourceDidSelectItemNotification,
            object: nil)
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: MenuTableDataSourceDidSelectItemNotification,
            object: nil)
    }
    //MARK: - Notifications
    func didSelectMenuItemNotification(notification: NSNotification?) {
        let menuItem: MenuItem? = notification!.object as? MenuItem
        if let tapHandler = tapHandlerBuilder?.tapHandlerForMenuItem(menuItem) {
            self.navigationController?.pushViewController(tapHandler, animated: true)
        }
    }
}

//
//  MenuTableDefaultDataSourceSpec.swift
//  QuickSwift
//
//  Created by Artem on 9/23/15.
//  Copyright © 2015 Rosberry. All rights reserved.
//

import Quick
import Nimble

class MenuTableDefaultDataSourceSpec: QuickSpec {
    var postedNotification: NSNotification?
    func didReceiveNotification(notification: NSNotification) {
        postedNotification = notification
    }
    override func spec() {
        describe("MenuTableDefaultDataSource") {
            var dataSource = MenuTableDefaultDataSource!()
            var menuItemsList = [MenuItem]!()
            let testMenuItem1 = MenuItem(title: "Test menu item 1")
            beforeSuite {
                dataSource = MenuTableDefaultDataSource()
                NSNotificationCenter.defaultCenter().addObserver(self,
                    selector: "didReceiveNotification:",
                    name: MenuTableDataSourceDidSelectItemNotification,
                    object: nil)
            }
            context("with one menu item") {
                it("should return one row.") {
                    menuItemsList = [testMenuItem1]
                    dataSource.setMenuItems(menuItemsList)
                    let numberOfRows = dataSource.tableView(UITableView(), numberOfRowsInSection:0)
                    expect(numberOfRows) == menuItemsList.count
                }
            }
            context("with two menu items") {
                let testMenuItem2 = MenuItem(title: "Test menu item 2")
                it("should return 2 rows.") {
                    menuItemsList = [testMenuItem1, testMenuItem2]
                    dataSource.setMenuItems(menuItemsList)
                    let numberOfRows = dataSource.tableView(UITableView(), numberOfRowsInSection: 0)
                    expect(numberOfRows) == menuItemsList.count
                }
            }
            it("should return one section.") {
                let numberOfSections = dataSource!.numberOfSectionsInTableView(UITableView())
                expect(numberOfSections) == 1
            }
            it("return cell with correct title.") {
                dataSource.setMenuItems([testMenuItem1])
                let firstMenuItem = NSIndexPath(forRow: 0, inSection: 0)
                let cell = dataSource.tableView(UITableView(), cellForRowAtIndexPath: firstMenuItem)
                expect(cell.textLabel!.text) == "Test menu item 1"
            }
            context ("post notification on cell selecting") {
                let selectedIndexPath = NSIndexPath(forRow: 0, inSection: 0)
                it ("with correct name.") {
                    dataSource.tableView(UITableView(), didSelectRowAtIndexPath:selectedIndexPath)
                    expect(self.postedNotification?.name) == MenuTableDataSourceDidSelectItemNotification
                }
                it ("with item object.") {
                    dataSource.tableView(UITableView(), didSelectRowAtIndexPath:selectedIndexPath)
                    expect(self.postedNotification?.object) === testMenuItem1
                }
            }
            afterSuite {
                NSNotificationCenter.defaultCenter().removeObserver(self)
            }
        }
    }
}

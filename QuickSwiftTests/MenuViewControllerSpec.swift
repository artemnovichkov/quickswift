//
//  MenuViewControllerSpec.swift
//  QuickSwift
//
//  Created by Artem on 9/24/15.
//  Copyright © 2015 Rosberry. All rights reserved.
//

import Quick
import Nimble

let postedNotification = "MenuViewControllerTestsPostedNotification"

class MenuViewControllerSpec: QuickSpec {
    override func spec() {
        describe ("MenuViewController") {
            var menuViewController: MenuViewController?
            var dataSource: MenuTableDataSource?
            var tableView: UITableView?
            var navigationController: UINavigationController?
            beforeSuite {
                menuViewController = MenuViewController()
                dataSource = MenuTableDefaultDataSource()
                tableView = UITableView()
                menuViewController?.dataSource = dataSource
                menuViewController?.tableView = tableView
                navigationController = UINavigationController(rootViewController: menuViewController!)
            }
            it("should have correct title.") {
                menuViewController?.viewDidLoad()
                expect(menuViewController!.title) == "App Menu"
            }
            it("should have correct dataSource.") {
                expect(menuViewController!.dataSource?.isEqual(dataSource)) == true
            }
            it("should have correct table view.") {
                expect(menuViewController!.tableView) === tableView
            }
            it ("should set dataSource as tableView' s data source.") {
                expect(tableView?.dataSource?.isEqual(dataSource)) == true
            }
            it ("should set dataSource as tableView' s delegate.") {
                expect(tableView?.delegate?.isEqual(dataSource)) == true
            }
            context ("with notification") {
                let notification = NSNotification(name: MenuTableDataSourceDidSelectItemNotification, object: nil)
                xit("should register it after viewWillAppear:.") {
                    self.swizzleNotificationHandler()
                    menuViewController?.viewWillAppear(false)
                    NSNotificationCenter.defaultCenter().postNotification(notification)
                    let object = objc_getAssociatedObject(menuViewController, postedNotification)
                    expect(object).toNot(beNil())
                }
                xit("should unregister it after viewWillDidDissappear:.") {
                    menuViewController?.viewDidAppear(false)
                    menuViewController?.viewDidDisappear(false)
                    NSNotificationCenter.defaultCenter().postNotification(notification)
                    expect(objc_getAssociatedObject(menuViewController, postedNotification)).to(beNil())
                }
            }
//            context ("after Contributions tapping") {
//                let menuItem = MenuItem(title: "Contributions")
//                menuItem.tapHandlerName = "ContributionsViewController"
//                let notification = NSNotification(name: MenuTableDataSourceDidSelectItemNotification, object: menuItem)
//                menuViewController?.didSelectMenuItemNotification(notification)
//                it ("should open ContributionsViewController.") {
//                    let topViewController = navigationController?.topViewController
//                    expect(topViewController).to(beAKindOf(ContributionsViewController.classForCoder()))
//                }
//            }
//            context ("after Repositories tapping") {
//                let menuItem = MenuItem(title: "Repositories")
//                menuItem.tapHandlerName = "RepositoriesViewController"
//                let notification = NSNotification(name: MenuTableDataSourceDidSelectItemNotification, object: menuItem)
//                menuViewController?.didSelectMenuItemNotification(notification)
//                it ("should open RepositoriesViewController.") {
//                    let topViewController = navigationController?.topViewController
//                    expect(topViewController).to(beAKindOf(RepositoriesViewController.classForCoder()))
//                }
//            }
//            context ("after PublicActivity tapping") {
//                let menuItem = MenuItem(title: "PublicActivity")
//                menuItem.tapHandlerName = "PublicActivityViewController"
//                let notification = NSNotification(name: MenuTableDataSourceDidSelectItemNotification, object: menuItem)
//                menuViewController?.didSelectMenuItemNotification(notification)
//                it ("should open PublicActivityViewController.") {
//                    let topViewController = navigationController?.topViewController
//                    expect(topViewController).to(beAKindOf(PublicActivityViewController.classForCoder()))
//                }
//            }
            afterSuite {
                objc_removeAssociatedObjects(menuViewController)
            }
        }
    }
    
    // MARK: - Method swizzling
    func swizzleNotificationHandler() {
        let realMethod: Method = class_getInstanceMethod(object_getClass(MenuViewController), Selector("didSelectMenuItemNotification:"))
        let testMethod: Method = class_getInstanceMethod(object_getClass(MenuViewController), Selector("testImpl_didSelectMenuItemNotification:"))
        method_exchangeImplementations(realMethod, testMethod)
    }
}

extension MenuViewController {
    func testImpl_didSelectMenuItemNotification(notification: NSNotification) {
        objc_setAssociatedObject(self, postedNotification, notification, .OBJC_ASSOCIATION_RETAIN)
    }
}

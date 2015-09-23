//
//  ObjectConfigurator.swift
//  QuickSwift
//
//  Created by Artem on 9/24/15.
//  Copyright © 2015 Rosberry. All rights reserved.
//

class ObjectConfigurator {
    func menuManager() -> AppMenuManager {
        let menuManager = AppMenuManager()
        let menuItemsPlistReader = MenuItemsPlistReader()
        
        menuItemsPlistReader.plistToReadFrom = "menuItems"
        menuManager.menuItemsReader = menuItemsPlistReader
        menuManager.menuItemsBuilder = MenuItemsDefaultBuilder()
        menuManager.objectConfigurator = self
        return menuManager
    }
    func menuViewController() -> MenuViewController {
        let menuViewController = MenuViewController(nibName: "MenuViewController", bundle: nil)
        menuViewController.dataSource = MenuTableDefaultDataSource()
        menuViewController.tapHandlerBuilder = MenuItemTapHandlerBuilder()
        return menuViewController
    }
}
//
//  AppMenuManager.swift
//  QuickSwift
//
//  Created by Artem on 9/24/15.
//  Copyright © 2015 Rosberry. All rights reserved.
//

import Foundation

class AppMenuManager {
    var menuItemsReader: MenuItemsReader?
    var menuItemsBuilder: MenuItemsBuilder?
    var objectConfigurator: ObjectConfigurator?
    
    func menuViewController() -> MenuViewController? {
        let (metadata, metadataError) = menuItemsReader!.readMenuItems()
        if metadataError != nil {
            tellUserAboutError(metadataError!)
        }
        else if let menuItems = menuItemsFromMetadata(metadata!) {
            return menuViewControllerFromMenuItems(menuItems)
        }
        return nil
    }
    private func tellUserAboutError(error: NSError) {
        print(error.localizedDescription)
    }
    private func menuItemsFromMetadata(metadata: [[String : String]]) -> [MenuItem]? {
        let (menuItems, builderError) = menuItemsBuilder!.buildMenuItemsFromMetadata(metadata)
        if builderError != nil {
            tellUserAboutError(builderError!)
            return nil
        }
        return menuItems
    }
    private func menuViewControllerFromMenuItems(menuItems: [MenuItem]) -> MenuViewController {
        let menuViewController = objectConfigurator?.menuViewController()
        let dataSource = menuViewController!.dataSource
        dataSource?.setMenuItems(menuItems)
        return menuViewController!
    }
}
//
//  MenuItemsDefaultBuilder.swift
//  QuickSwift
//
//  Created by Artem on 9/23/15.
//  Copyright © 2015 Rosberry. All rights reserved.
//

import Foundation

let MenuItemsDefaultBuilderErrorDomain = "MenuItemsBuilderErrorDomain"

enum MenuItemsDefaultBuilderErrorCode : Int {
    case MissingTitle
}

class MenuItemsDefaultBuilder: MenuItemsBuilder {
    //MARK: - MenuItemsBuilder
    func buildMenuItemsFromMetadata(metadata: [[String : String]]) -> ([MenuItem]?, NSError?) {
        var menuItems = [MenuItem]()
        var error: NSError?
        for dictionary in metadata {
            if let title = dictionary["title"] {
                let menuItem = MenuItem(title: title)
                menuItem.subtitle = dictionary["subTitle"]
                menuItem.iconName = dictionary["iconName"]
                menuItem.tapHandlerName = dictionary["tapHandlerName"]
                menuItems.append(menuItem)
            }
            else {
                error = missingTitleError()
                menuItems.removeAll(keepCapacity: false)
                break
            }
        }
        return (menuItems, error)
    }
    //MARK:
    private func missingTitleError() -> NSError {
        let userInfo = [NSLocalizedDescriptionKey: "All menu items must have a title"]
        
        return NSError(domain: MenuItemsDefaultBuilderErrorDomain,
            code: MenuItemsDefaultBuilderErrorCode.MissingTitle.rawValue,
            userInfo: userInfo)
    }
}
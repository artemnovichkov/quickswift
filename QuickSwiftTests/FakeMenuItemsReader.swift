//
//  FakeMenuItemsReader.swift
//  QuickSwift
//
//  Created by Artem on 9/23/15.
//  Copyright © 2015 Rosberry. All rights reserved.
//

import Foundation

class FakeMenuItemsReader: MenuItemsReader {
    var missingTitle: Bool = false
    var errorToReturn: NSError? = nil
    
    func readMenuItems() -> ([[String : String]]?, NSError?) {
        if errorToReturn != nil {
            return (nil, errorToReturn)
        }
        else {
            let menuItem1 = missingTitle ? menuItem1WithMissingTitle() : menuItem1WithNoMissingTitle()
            let menuItem2 = ["title": "Menu Item 2",
                "subTitle": "Menu Item 2 subtitle",
                "iconName": "iconName2",
                "tapHandlerName": "someViewController1"]
            return ([menuItem1, menuItem2], nil)
        }
    }
    func menuItem1WithMissingTitle() -> [String : String] {
        return ["subTitle" : "Menu Item 1 subtitle",
            "iconName" : "iconName1",
            "tapHandlerName": "someViewController2"]
    }
    func menuItem1WithNoMissingTitle() -> [String : String] {
        var menuItem = menuItem1WithMissingTitle()
        menuItem["title"] = "Menu Item 1"
        return menuItem
    }
}
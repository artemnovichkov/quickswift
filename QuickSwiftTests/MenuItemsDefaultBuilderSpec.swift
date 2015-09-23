//
//  MenuItemBuilderSpec.swift
//  QuickSwift
//
//  Created by Artem on 9/23/15.
//  Copyright © 2015 Rosberry. All rights reserved.
//

import Quick
import Nimble

class MenuItemsDefaultBuilderSpec: QuickSpec {
    override func spec() {
        describe("MenuItemsBuilder") {
            let menuItemsBuilder = MenuItemsDefaultBuilder()
            let fakeMenuItemsReader = FakeMenuItemsReader()
            var menuItems: [MenuItem]?
            context("with missing title") {
                fakeMenuItemsReader.missingTitle = true
                let (metadata, _) = fakeMenuItemsReader.readMenuItems()
                var error: NSError?
                (_, error) = menuItemsBuilder.buildMenuItemsFromMetadata(metadata!)
                it("should return correct error code.") {
                    let errorCode = error?.code
                    expect(errorCode) == MenuItemsDefaultBuilderErrorCode.MissingTitle.rawValue
                }
                it("should return correct error domain.") {
                    let errorDomain = error?.domain
                    expect(errorDomain) == MenuItemsDefaultBuilderErrorDomain
                }
                it("should return correct error description.") {
                    let userInfo = error?.userInfo
                    let description: String = userInfo![NSLocalizedDescriptionKey] as! String
                    expect(description) == "All menu items must have a title"
                }
            }
            context("with title") {
                fakeMenuItemsReader.missingTitle = false
                let (metadata, _) = fakeMenuItemsReader.readMenuItems()
                (menuItems, _) = menuItemsBuilder.buildMenuItemsFromMetadata(metadata!)
                it("should return 2 items.") {
                    expect(menuItems?.count) == 2
                }
                let rawDictionary1 = metadata![0]
                let menuItem1 = menuItems![0]
                it("should parse first item's title.") {
                    expect(menuItem1.title) == rawDictionary1["title"]
                }
                it("should parse first item's subtitle.") {
                    expect(menuItem1.subtitle) == rawDictionary1["subTitle"]
                }
                it("should parse first item's icon name.") {
                    expect(menuItem1.iconName) == rawDictionary1["iconName"]
                }
                it("should parse first item's tap handler.") {
                    expect(menuItem1.tapHandlerName) == rawDictionary1["tapHandlerName"]
                }
                let rawDictionary2 = metadata![1]
                let menuItem2 = menuItems![1]
                it("should parse second item's title.") {
                    expect(menuItem2.title) == rawDictionary2["title"]
                }
                it("should parse second item's subtitle.") {
                    expect(menuItem2.subtitle) == rawDictionary2["subTitle"]
                }
                it("should parse second item's icon name.") {
                    expect(menuItem2.iconName) == rawDictionary2["iconName"]
                }
                it("should parse second item's tap handler.") {
                    expect(menuItem2.tapHandlerName) == rawDictionary2["tapHandlerName"]
                }
            }
        }
    }
}

//
//  MenuItemSpec.swift
//  QuickSwift
//
//  Created by Artem on 9/23/15.
//  Copyright © 2015 Rosberry. All rights reserved.
//

import Quick
import Nimble

class MenuItemSpec: QuickSpec {
    override func spec() {
        describe("Menu item with a title") {
            let title = "Title"
            let menuItem = MenuItem(title: title)
            it("should always have it.") {
                expect(menuItem.title) == title
            }
            context("and subtitle") {
                let subtitle = "subtitle"
                menuItem.subtitle = subtitle
                it("should have subtitle.") {
                    expect(menuItem.subtitle) == subtitle
                }
            }
            context("and icon") {
                let iconName = "iconName"
                menuItem.iconName = iconName
                it("should have icon.") {
                    expect(menuItem.iconName) == iconName
                }
            }
            context ("with tapping") {
                let tapHandlerName = "someViewController"
                menuItem.tapHandlerName = tapHandlerName
                it ("should have tap handler name.") {
                    expect(menuItem.tapHandlerName) == tapHandlerName
                }
            }
        }
    }
}
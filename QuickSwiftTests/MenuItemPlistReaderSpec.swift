//
//  MenuItemPlistReaderSpec.swift
//  QuickSwift
//
//  Created by Artem on 9/23/15.
//  Copyright © 2015 Rosberry. All rights reserved.
//

import Quick
import Nimble

class MenuItemPlistReaderSpec: QuickSpec {
    override func spec() {
        describe("MenuItemPlistReader") {
            let plistReader = MenuItemsPlistReader()
            context("with wrong link ") {
                plistReader.plistToReadFrom = "notFound"
                let (_, error) = plistReader.readMenuItems()
                it("should return correct error code.") {
                    let errorCode = error?.code
                    expect(errorCode) == MenuItemsPlistReaderErrorCode.FileNotFound.rawValue
                }
                it("should return correct error description.") {
                    let userInfo = error?.userInfo
                    let description: String = userInfo![NSLocalizedDescriptionKey]! as! String
                    expect(description) == "notFound.plist file doesn't exist in app bundle"
                }
            }
            context("with correct link") {
                plistReader.plistToReadFrom = "menuItems"
                let (metadata, _) = plistReader.readMenuItems()
                it("should parse only three dictionaries from plist.") {
                    expect(metadata?.count) == 3
                }
                
                let firstRow = metadata?[0]
                it("should have first row's title in metadata.") {
                    expect(firstRow!["title"]) == "Contributions"
                }
                it("should have first row's title in metadata.") {
                    expect(firstRow!["subTitle"]) == "Repos contributed to"
                }
                it("should have first row's title in metadata.") {
                    expect(firstRow!["iconName"]) == "iconContributions"
                }
                it("should have first row's tap handler in metadata.") {
                    expect(firstRow!["tapHandlerName"]) == "ContributionsViewController"
                }
                
                let secondRow = metadata?[1]
                it("should have second row's title in metadata.") {
                    expect(secondRow!["title"]) == "Repositories"
                }
                it("should have second row's title in metadata.") {
                    expect(secondRow!["subTitle"]) == "Repos collaborating"
                }
                it("should have second row's title in metadata.") {
                    expect(secondRow!["iconName"]) == "iconRepositories"
                }
                it("should have first row's tap handler in metadata.") {
                    expect(secondRow!["tapHandlerName"]) == "RepositoriesViewController"
                }
                
                let thirdRow = metadata?[2]
                it("should have third row's title in metadata.") {
                    expect(thirdRow!["title"]) == "Public Activity"
                }
                it("should have third row's title in metadata.") {
                    expect(thirdRow!["subTitle"]) == "Activity viewable by anyone"
                }
                it("should have third row's title in metadata.") {
                    expect(thirdRow!["iconName"]) == "iconPublicActivity"
                }
                it("should have first row's tap handler in metadata.") {
                    expect(thirdRow!["tapHandlerName"]) == "PublicActivityViewController"
                }
            }
        }
    }
}

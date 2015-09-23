//
//  MenuItemTapHandlerBuilder.swift
//  QuickSwift
//
//  Created by Artem on 9/28/15.
//  Copyright © 2015 Rosberry. All rights reserved.
//

import UIKit

class MenuItemTapHandlerBuilder {
    func tapHandlerForMenuItem(menuItem: MenuItem?) -> UIViewController? {
        var tapHandler: UIViewController?
        if menuItem != nil {
            switch menuItem!.tapHandlerName! {
            case "ContributionsViewController":
                tapHandler = ContributionsViewController(
                    nibName: "ContributionsViewController",
                    bundle: nil)
            case "RepositoriesViewController":
                tapHandler = RepositoriesViewController(
                    nibName: "RepositoriesViewController",
                    bundle: nil)
            case "PublicActivityViewController":
                tapHandler = PublicActivityViewController(
                    nibName: "PublicActivityViewController",
                    bundle: nil)
            default:
                tapHandler = nil
            }
        }
        return tapHandler
    }
}

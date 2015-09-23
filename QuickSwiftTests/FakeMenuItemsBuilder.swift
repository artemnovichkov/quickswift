//
//  FakeMenuItemsBuilder.swift
//  QuickSwift
//
//  Created by Artem on 9/24/15.
//  Copyright © 2015 Rosberry. All rights reserved.
//

import Foundation

class FakeMenuItemsBuilder: MenuItemsBuilder {
    var errorToReturn: NSError? = nil
    var menuItemsToReturn: [MenuItem]? = nil
    var metadata: [[String : String]]? = nil
    
    func buildMenuItemsFromMetadata(metadata: [[String : String]]) -> ([MenuItem]?, NSError?) {
        self.metadata = metadata
        return (menuItemsToReturn, errorToReturn)
    }
}

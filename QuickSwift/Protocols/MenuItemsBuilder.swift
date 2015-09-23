//
//  MenuItemBuilder.swift
//  QuickSwift
//
//  Created by Artem on 9/24/15.
//  Copyright © 2015 Rosberry. All rights reserved.
//

import Foundation

protocol MenuItemsBuilder {
    func buildMenuItemsFromMetadata(metadata: [[String : String]]) -> ([MenuItem]?, NSError?)
}
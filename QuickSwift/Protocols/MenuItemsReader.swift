//
//  MenuItemsReader.swift
//  QuickSwift
//
//  Created by Artem on 9/23/15.
//  Copyright © 2015 Rosberry. All rights reserved.
//

import Foundation

protocol MenuItemsReader {
    func readMenuItems() -> ([[String : String]]?, NSError?)
}
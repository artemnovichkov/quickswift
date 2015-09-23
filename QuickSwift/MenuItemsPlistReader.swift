//
//  MenuItemsPlistReader.swift
//  QuickSwift
//
//  Created by Artem on 9/23/15.
//  Copyright © 2015 Rosberry. All rights reserved.
//

import Foundation

let MenuItemsPlistErrorDomain = "MenuItemsPlistReaderErrorDomain"

enum MenuItemsPlistReaderErrorCode: Int {
    case FileNotFound
}

class MenuItemsPlistReader: MenuItemsReader {
    var plistToReadFrom: String? = nil
    
    func readMenuItems() -> ([[String : String]]?, NSError?) {
        var error: NSError? = nil
        var fileContents: [[String : String]]? = nil
        let bundle = NSBundle(forClass: object_getClass(self))
        if let filePath = bundle.pathForResource(plistToReadFrom, ofType: "plist") {
            fileContents = NSArray(contentsOfFile: filePath) as? [[String : String]]
        }
        else {
            let errorMessage = "\(plistToReadFrom!).plist file doesn't exist in app bundle"
            let userInfo = [NSLocalizedDescriptionKey : errorMessage]
            error = NSError(domain: MenuItemsPlistErrorDomain, code: MenuItemsPlistReaderErrorCode.FileNotFound.rawValue, userInfo: userInfo)
        }
        return (fileContents, error)
    }
}
//
//  ItemsManager.swift
//  Scavenger Hunt
//
//  Created by Romil kumar Vasani on 14/11/15.
//  Copyright © 2015 Apple. All rights reserved.
//

import UIKit

class ItemsManager {
    var itemsList = [ScavengerHuntItem]()
    
    func archivePath() -> String? {
        let directoryList = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        if let documentDirectory = directoryList.first {
            return documentDirectory + "/ScavengerHuntItem"
        }
        assertionFailure("Could not determine where to save the File")
        return nil
    }
    
    func save() {
        if let theArchivePath = archivePath() {
            if NSKeyedArchiver.archiveRootObject(itemsList, toFile: theArchivePath) {
                print("Saved Successfully")
            } else {
                assertionFailure("Could not save to \(theArchivePath)")
            }
        }
    }
    
    func unarchiveSavedItems() {
        if let theArchivePath = archivePath() {
            if NSFileManager.defaultManager().fileExistsAtPath(theArchivePath) {
                itemsList = NSKeyedUnarchiver.unarchiveObjectWithFile(theArchivePath) as! [ScavengerHuntItem]
            }
        }
    }
    
    init() {
        unarchiveSavedItems()
    }
}

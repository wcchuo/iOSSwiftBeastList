//
//  Beast.swift
//  iOSPractice
//
//  Created by Wei Chung Chuo on 8/14/15.
//  Copyright © 2015 Wei Chung Chuo. All rights reserved.
//

import Foundation
class Beast: NSObject, NSCoding {
    static var key: String = "Beast"
    static var schema: String = "theList"
    var objective: String
    var createdAt: NSDate
    var beasted: String
    // use this init for creating a new Beast
    init(obj: String, beastedCheck: String) {
        objective = obj
        createdAt = NSDate()
        beasted = beastedCheck
    }
    // MARK: - NSCoding protocol
    // used for encoding (saving) objects
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(objective, forKey: "objective")
        aCoder.encodeObject(createdAt, forKey: "createdAt")
        aCoder.encodeObject(beasted, forKey: "beasted")
    }
    // used for decoding (loading) objects
    required init?(coder aDecoder: NSCoder) {
        objective = aDecoder.decodeObjectForKey("objective") as! String
        createdAt = aDecoder.decodeObjectForKey("createdAt") as! NSDate
        beasted = aDecoder.decodeObjectForKey("beasted") as! String
        super.init()
    }
    // MARK: - Queries
    static func all() -> [Beast] {
        var tasks = [Beast]()
        let path = Database.dataFilePath("theList")
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                tasks = unarchiver.decodeObjectForKey(Beast.key) as! [Beast]
                unarchiver.finishDecoding()
            }
        }
        return tasks
    }

    
    func save() {
        var beastsFromStorage = Beast.all()
        var exists = false
        for var i = 0; i < beastsFromStorage.count; ++i {
            if beastsFromStorage[i].createdAt == self.createdAt {
                beastsFromStorage[i] = self
                exists = true
            }
        }
        if !exists {
            beastsFromStorage.append(self)
        }
        Database.save(beastsFromStorage, toSchema: Beast.schema, forKey: Beast.key)
    }
    func destroy() {
        var beastsFromStorage = Beast.all()
        for var i = 0; i < beastsFromStorage.count; ++i {
            if beastsFromStorage[i].createdAt == self.createdAt {
                beastsFromStorage.removeAtIndex(i)
            }
        }
        Database.save(beastsFromStorage, toSchema: Beast.schema, forKey: Beast.key)
    }
}




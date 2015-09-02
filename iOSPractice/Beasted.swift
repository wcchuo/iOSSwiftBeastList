//
//  Beasted.swift
//  iOSPractice
//
//  Created by Wei Chung Chuo on 8/14/15.
//  Copyright © 2015 Wei Chung Chuo. All rights reserved.
//

import Foundation
class Beasted: NSObject, NSCoding {
    static var key: String = "Beasted"
    static var schema: String = "theList"
    var objective: String
    var createdAt: NSDate
    // use this init for creating a new Beasted
    init(obj: String) {
        objective = obj
        createdAt = NSDate()
    }
    // MARK: - NSCoding protocol
    // used for encoding (saving) objects
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(objective, forKey: "objective")
        aCoder.encodeObject(createdAt, forKey: "createdAt")
    }
    // used for decoding (loading) objects
    required init?(coder aDecoder: NSCoder) {
        objective = aDecoder.decodeObjectForKey("objective") as! String
        createdAt = aDecoder.decodeObjectForKey("createdAt") as! NSDate
        super.init()
    }
    // MARK: - Queries
    static func all() -> [Beasted] {
        var tasks = [Beasted]()
        let path = Database.dataFilePath("theList")
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                tasks = unarchiver.decodeObjectForKey(Beasted.key) as! [Beasted]
                unarchiver.finishDecoding()
            }
        }
        return tasks
    }
    
    
    func toBeast() {
        var beastsFromStorage = Beasted.all()
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
        Database.save(beastsFromStorage, toSchema: Beasted.schema, forKey: Beasted.key)
    }
    
    
    static func beasted() -> [Beasted] {
        var tasks = [Beasted]()
        let path = Database.dataFilePath("theList")
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                tasks = unarchiver.decodeObjectForKey(Beasted.key) as! [Beasted]
                unarchiver.finishDecoding()
            }
        }
        return tasks
    }
    
    func save() {
        var beastsFromStorage = Beasted.all()
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
        Database.save(beastsFromStorage, toSchema: Beasted.schema, forKey: Beasted.key)
    }
    func destroy() {
        var beastsFromStorage = Beasted.all()
        for var i = 0; i < beastsFromStorage.count; ++i {
            if beastsFromStorage[i].createdAt == self.createdAt {
                beastsFromStorage.removeAtIndex(i)
            }
        }
        Database.save(beastsFromStorage, toSchema: Beasted.schema, forKey: Beasted.key)
    }
}




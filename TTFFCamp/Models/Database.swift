//
//  Database.swift
//  TTFFCamp
//
//  Created by Jimmy Nguyen on 3/10/16.
//  Copyright © 2016 The Taylor Family Foundation. All rights reserved.
//

import Foundation

class Database {
    // get the full path to the Documents folder
    static func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    
    // get the full path to file of project
    static func dataFilePath(schema: String) -> String {
        return "\(Database.documentsDirectory())/\(schema)"
    }
    
    static func save(arrayOfObjects: [AnyObject], toSchema: String, forKey: String) {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(arrayOfObjects, forKey: "\(forKey)")
        archiver.finishEncoding()
        data.writeToFile(Database.dataFilePath(toSchema), atomically: true)
        //print("saved data", data)
    }
    
    
    static func all() -> [Plant] {
        var plants = [Plant]()
        
        let path = Database.dataFilePath(Plant.schema)
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                plants = unarchiver.decodeObjectForKey(Plant.key) as! [Plant]
                unarchiver.finishDecoding()
            }
        }
        return plants
    }

}
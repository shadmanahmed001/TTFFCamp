//
//  Plant.swift
//  TTFFCamp
//
//  Created by Jimmy Nguyen on 3/10/16.
//  Copyright © 2016 The Taylor Family Foundation. All rights reserved.
//

import Foundation

class Plant: NSObject, NSCoding {
    
    //variable declaration
    static var key = "Plants"
    static var schema = "PlantSchema"
    var plantName: String
    var location: String
    var origin: String
    var plantDescription: String
    var whenToPlant: String
    var coolFact: String
    var moreFacts: String
    var image: String
    var createdAt: NSDate
    
    //init method for new obj instances
    override init (){
        self.plantName = ""
        self.location = ""
        self.origin = ""
        self.plantDescription = ""
        self.whenToPlant = ""
        self.coolFact = ""
        self.moreFacts = ""
        self.image = ""
        createdAt = NSDate()
    }
    
    // MARK: - NSCoding protocol
    // used for encoding (saving) objects
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(plantName, forKey: "plantName")
        aCoder.encodeObject(location, forKey: "location")
        aCoder.encodeObject(origin, forKey: "origin")
        aCoder.encodeObject(plantDescription, forKey: "plantDescription")
        aCoder.encodeObject(whenToPlant, forKey: "whenToPlant")
        aCoder.encodeObject(coolFact, forKey: "coolFact")
        aCoder.encodeObject(moreFacts, forKey: "moreFacts")
        aCoder.encodeObject(image, forKey: "images")
        aCoder.encodeObject(createdAt, forKey:  "createdAt")
    }
    // used for decoding (loading) objects
    required init?(coder aDecoder: NSCoder) {
        plantName = aDecoder.decodeObjectForKey("plantName") as! String
        location = aDecoder.decodeObjectForKey("location") as! String
        origin = aDecoder.decodeObjectForKey("origin") as! String
        plantDescription = aDecoder.decodeObjectForKey("plantDescription") as! String
        whenToPlant = aDecoder.decodeObjectForKey("whenToPlant") as! String
        coolFact = aDecoder.decodeObjectForKey("coolFact") as! String
        moreFacts = aDecoder.decodeObjectForKey("moreFacts") as! String
        image = aDecoder.decodeObjectForKey("images") as! String
        createdAt = aDecoder.decodeObjectForKey("createdAt") as! NSDate
        super.init()
    }
    
    
}
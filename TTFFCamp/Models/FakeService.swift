//
//  FakeService.swift
//  TTFFCamp
//
//  Created by yanze on 3/13/16.
//  Copyright © 2016 The Taylor Family Foundation. All rights reserved.
//

import Foundation

class FakeService{
    
    static func getFakePlants() -> [Plant] {
        let ttff1000001 = Plant()
        ttff1000001.plantName = "Forget Me Not"
        ttff1000001.location = "Main Gate"
        ttff1000001.origin = "New Zealand"
        ttff1000001.whenToPlant = "Spring"
        ttff1000001.coolFact = "The Forget Me Not is the official flower of Alaska"
        ttff1000001.moreFacts = "More Facts for Forget Me Not"
        ttff1000001.images = "img1.png"
        
        let ttff1000002 = Plant()
        ttff1000002.plantName = "Purple Sage"
        ttff1000002.location = "East Gate"
        ttff1000002.origin = "United States"
        ttff1000002.whenToPlant = "Spring"
        ttff1000002.coolFact = "Ancient Romans used sage for treatment for snake bites, and also as memory enhancer"
        ttff1000002.moreFacts = "More Facts for Purple Sage"
        ttff1000002.images = "img2.png"
        
        return [ttff1000001, ttff1000002]
    }
}
//
//  plantInfoViewController.swift
//  TTFFCamp
//
//  Created by yanze on 3/9/16.
//  Copyright © 2016 The Taylor Family Foundation. All rights reserved.
//

import UIKit
import AVFoundation
import Auk
import Alamofire

class PlantInfoViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var plantTitleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var whenToPlantLabel: UILabel!
    @IBOutlet weak var coolFactLabel: UILabel!
    @IBOutlet weak var moreFactsLabel: UILabel!
    @IBOutlet weak var imagesLabel: UILabel!
    
    
    var plantObj = Plant()
    
    
    var detectedText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        plantTitleLabel.text = detectedText
        plantObj = retrievePlant(detectedText)
        plantTitleLabel.text = plantObj.plantName
        locationLabel.text = "Location: \(plantObj.location[0] as? String)"
        originLabel.text = "Origin: \(plantObj.origin)"
        whenToPlantLabel.text = "When To Plant: \(plantObj.whenToPlant)"
        coolFactLabel.text = "Cool Fact: \(plantObj.coolFact)"
        moreFactsLabel.text = "More Facts: \(plantObj.moreFacts[0] as? String)"
        imagesLabel.text = "Image Names: \(plantObj.images[0] as? String)"
        
        
        
        Alamofire.request(.GET, "https://api.github.com/users/yanze")
            .responseJSON { response in
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    //                    self.plantTitleLabel.text = "\(JSON)!"
                }
        }
        
        
    }
    
    func retrievePlant(detectedPlant: String) -> Plant {
        
        // Hard-coded plant data
        let ttff1000001 = Plant()
        ttff1000001.plantName = "Forget Me Not"
        ttff1000001.location = ["Main Gate"]
        ttff1000001.origin = "New Zealand"
        ttff1000001.whenToPlant = "Spring"
        ttff1000001.coolFact = "The Forget Me Not is the official flower of Alaska"
        ttff1000001.moreFacts = ["new fact 1", "new fact 2"]
        ttff1000001.images = ["img1.png", "img2.png"]
        
        let ttff1000002 = Plant()
        ttff1000002.plantName = "Purple Sage"
        ttff1000002.location = ["Main Gate", "East Gate"]
        ttff1000002.origin = "United States"
        ttff1000002.whenToPlant = "Spring"
        ttff1000002.coolFact = "Ancient Romans used sage for treatment for snake bites, and also as memory enhancer"
        ttff1000002.moreFacts = ["new fact 1", "new fact 2"]
        ttff1000002.images = ["img1.png", "img2.png"]
        
        var plants: [AnyObject] = []
        
        plants.append(ttff1000001)
        plants.append(ttff1000002)
        
        for var i = 0; i < plants.count; i++ {
            if plants[i].plantName == detectedPlant {
                print("found the correct plant ID", plants[i])
                return plants[i] as! Plant
            }
        }
        
        
        print("First", ttff1000001)
        print("Second", ttff1000002)
        print(plants)
        
        // Placeholder:  If for loop fails, it just prints out the first Plant Obj.  Just here so app doesn't break if plant is not found.
        return ttff1000001
        
    }
    
    
    
    
}
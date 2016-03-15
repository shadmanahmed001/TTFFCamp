//
//  HiddenMenuViewController.swift
//  TTFFCamp
//
//  Created by yanze on 3/13/16.
//  Copyright © 2016 The Taylor Family Foundation. All rights reserved.
//

import UIKit
import Alamofire


class HiddenMenuViewController: UIViewController {
    
    @IBOutlet weak var userInputLabel: UITextField!
    
    @IBAction func clickToSynchronize(sender: UIButton) {
        
        Alamofire.request(.GET, "http://192.168.1.192:8000/getAllPlants")
            
            
            .responseJSON { response in
                if let JSON = response.result.value {
                    print("json data", JSON)
                    
                    var plantArray = [Plant]()
                    
                    // parse JSON data and create new Plant objs and Plant array
                    for anItem in JSON as! [Dictionary<String, AnyObject>] {
                        let plantObj = Plant()
                        plantObj.plantName = anItem["name"] as! String
                        plantObj.location = anItem["location"] as! String
                        plantObj.origin = anItem["origin"] as! String
                        plantObj.whenToPlant = anItem["whenToPlant"] as! String
                        plantObj.coolFact = anItem["coolFact"] as! String
                        plantObj.moreFacts = anItem["moreFact"] as! String
                        plantObj.images = anItem["filename"] as! String
                        
                        plantArray.append(plantObj)
                        
                    }
                    
                    print("new plant array", plantArray)
                    
                    
                    Database.save(plantArray, toSchema: Plant.schema, forKey: Plant.key) // save all to local storage
                }
                
                
                
        }
        
        
    }
    
    
    
    
}
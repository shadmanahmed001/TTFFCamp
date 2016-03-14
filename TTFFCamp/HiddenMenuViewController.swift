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
                    // TODO: convert JSON content to an array of plants
                    // TODO: replace fake data with correct ajax return result
                    
                    print("json data", JSON)
                    
                    let fakePlants = FakeService.getFakePlants() // get all plants from db
                    
                    print("fakePlants", fakePlants)
                    Database.save(fakePlants, toSchema: Plant.schema, forKey: Plant.key) // save all to local storage
                }
                
                
                
        }
        
        
    }
    
    
    
    
}
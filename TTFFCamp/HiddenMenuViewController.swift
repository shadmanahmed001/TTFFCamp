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
        Alamofire.request(.GET, "https://api.github.com/users/yanze")
            
            
            .responseJSON { response in
                if let JSON = response.result.value {
                    // TODO: convert JSON content to an array of plants
                    // TODO: replace fake data with correct ajax return result
                    let fakePlants = FakeService.getFakePlants()
                    
                    Database.save(fakePlants, toSchema: Plant.schema, forKey: Plant.key)
                }
        }
        
    }
    
    
    
    
}
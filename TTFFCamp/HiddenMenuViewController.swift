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
    @IBOutlet weak var messageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.hidden = true
        messageLabel.textColor = UIColor.redColor()
    }
    
    @IBAction func clickToSynchronize(sender: UIButton) {

        // http://192.168.1.192:8000/getAllPlants
        
        if userInputLabel.text == "yanze" {
            messageLabel.hidden = true
            Alamofire.request(.GET, "https://api.github.com/users/\(userInputLabel.text!)")
                .responseJSON { response in
                    if let JSON = response.result.value {
                        // TODO: convert JSON content to an array of plants
                        // TODO: replace fake data with correct ajax return result
                        print("\(JSON)")
//                        let fakePlants = FakeService.getFakePlants() // get all plants from db
//                        Database.save(fakePlants, toSchema: Plant.schema, forKey: Plant.key) // save all to local storage
                    }
            }
            
        }
        else {
            messageLabel.hidden = false
            messageLabel.text = "Wrong Entry"
        }

        
    }
    
    
    
    
}
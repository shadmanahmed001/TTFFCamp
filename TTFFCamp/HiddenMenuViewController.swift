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
    @IBOutlet weak var testImage: UIImageView!
    
    let socket = SocketIOClient(socketURL: "http://192.168.1.35:5000")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.hidden = true
        messageLabel.textColor = UIColor.redColor()
        
//        socket.connect()
//        socket.on("connection") { data, ack in
//            //print(data)
//            print("iOS::we are using sockets")
//            
//        }
    }
    
    @IBAction func clickToSynchronize(sender: UIButton) {

        // http://192.168.1.192:8000/getAllPlants
        
        socket.connect()
        socket.on("connection") { data, ack in
            //print(data)
            print("iOS::we are using sockets")
            
        }
        
        socket.on("image") { data, ack in
            
//            print("data", data)
            
            
            
            let receivedData = data[0]["buffer"] as! String
            let imageData = NSData(base64EncodedString: receivedData, options: NSDataBase64DecodingOptions(rawValue: 0))
            
            let image = UIImage(data: imageData!)
            
            self.testImage.image = image
            
            
        }
        
        
        
        
        
        
        // UNCOMMENT LATER Section 1
//        if userInputLabel.text == "yanze" {
//            messageLabel.hidden = true
//            Alamofire.request(.GET, "https://api.github.com/users/\(userInputLabel.text!)")
//                .responseJSON { response in
//                    if let JSON = response.result.value {
//                        // TODO: convert JSON content to an array of plants
//                        // TODO: replace fake data with correct ajax return result
//                        print("\(JSON)")
////                        let fakePlants = FakeService.getFakePlants() // get all plants from db
////                        Database.save(fakePlants, toSchema: Plant.schema, forKey: Plant.key) // save all to local storage
//                    }
//            }
        
        
        
        
        
        
//            .responseJSON { response in
//                if let JSON = response.result.value {
//                    print("json data", JSON)
//                    
//                    var plantArray = [Plant]()
//                    
//                    // parse JSON data and create new Plant objs and Plant array
//                    for anItem in JSON as! [Dictionary<String, AnyObject>] {
//                        let plantObj = Plant()
//                        plantObj.plantName = anItem["name"] as! String
//                        plantObj.location = anItem["location"] as! String
//                        plantObj.origin = anItem["origin"] as! String
//                        plantObj.whenToPlant = anItem["whenToPlant"] as! String
//                        plantObj.coolFact = anItem["coolFact"] as! String
//                        plantObj.moreFacts = anItem["moreFact"] as! String
//                        plantObj.images = anItem["filename"] as! String
//                        
//                        plantArray.append(plantObj)
//                        
//                    }
//                    
//                    print("new plant array", plantArray)
//                    
//                    
//                    Database.save(plantArray, toSchema: Plant.schema, forKey: Plant.key) // save all to local storage
//                }
            
        // UNCOMMENT LATER Section 2
//        }
//        else {
//            messageLabel.hidden = false
//            messageLabel.text = "Wrong Entry"
//        }
//
//        
    }
    
    
    
    
}
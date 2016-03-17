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
    
    let socket = SocketIOClient(socketURL: "http://192.168.1.192:8000")
    
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
        
//        socket.on("image") { data, ack in
//            
//            print("data", data)
//            
//            let receivedData = data[0]["buffer"] as! String
//            let imageData = NSData(base64EncodedString: receivedData, options: NSDataBase64DecodingOptions(rawValue: 0))
//            
//            let image = UIImage(data: imageData!)
//            
//            self.testImage.image = image
//            
//            
//        }
        
        
        
        
        if userInputLabel.text == "yanze" {
            messageLabel.hidden = true
//            Alamofire.request(.GET, "https://api.github.com/users/\(userInputLabel.text!)")
            Alamofire.request(.GET, "http://192.168.1.192:8000/getAllPlants")
                .responseJSON { response in
                    if let JSON = response.result.value {
                        print("json data", JSON)
                    
                        var plantArray = [Plant]()
                    
                        // parse JSON data and create new Plant objs and Plant array
                        for anItem in JSON as! [Dictionary<String, AnyObject>] {
                            let plantObj = Plant()
                            if let newName = anItem["name"] {
                                plantObj.plantName = newName as! String
                            }
                            if let newLocation = anItem["location"] {
                                plantObj.location = newLocation as! String
                            }
                            if let newOrigin = anItem["origin"] {
                                plantObj.origin = newOrigin as! String
                            }
                            if let newWTP = anItem["whenToPlant"] {
                                plantObj.whenToPlant = newWTP as! String
                            }
                            if let newCF = anItem["coolFact"] {
                                plantObj.coolFact = newCF as! String
                            }
                            if let newMF = anItem["moreFact"] {
                                plantObj.moreFacts = newMF as! String
                            }
                            if let newImage = anItem["imgStr"] {
                                plantObj.image = newImage as! String
                            }
                            
                    
                            plantArray.append(plantObj)
                                            
                        }
                                        
                    print("new plant array", plantArray)
                                        
                                        
                    Database.save(plantArray, toSchema: Plant.schema, forKey: Plant.key) // save all to local storage
                    }
                }
        }
        else {
            messageLabel.hidden = false
            messageLabel.text = "Wrong Entry"
        }
        
    }
    
}
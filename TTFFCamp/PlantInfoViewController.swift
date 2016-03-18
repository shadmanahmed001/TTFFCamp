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


class PlantInfoViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var plantNameButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var originButton: UIButton!
    @IBOutlet weak var whenToPlantButton: UIButton!
    @IBOutlet weak var coolFactButton: UIButton!
    @IBOutlet weak var moreFactsButton: UIButton!
    @IBOutlet weak var plantImage: UIImageView!

    //MARK: NSSpeech
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
    //MARK:
    var singlePlant = Plant()
    var allPlants: [Plant] = []
    
    var detectedText = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        customButtons()
        
        // get all plants from local storage
        allPlants = Database.all()
        getPlantByName(detectedText)
        
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)    
        self.navigationItem.setHidesBackButton(editing, animated: animated)
    }
    
    
    func getPlantByName(plantName: String){
        for var i = 0; i < allPlants.count; i++ {
            if allPlants[i].plantName == plantName {
                print("found the correct plant ID", allPlants[i])
                singlePlant = allPlants[i]
                print(singlePlant.plantName)
                
            }
        }

        plantNameButton.setTitle(singlePlant.plantName, forState: UIControlState.Normal)
        locationButton.setTitle("Location: \(singlePlant.location)", forState: UIControlState.Normal)
        originButton.setTitle("Origin: \(singlePlant.origin)", forState: UIControlState.Normal)
        whenToPlantButton.setTitle("When To Plant: \(singlePlant.whenToPlant)", forState: UIControlState.Normal)
        coolFactButton.setTitle("Cool Fact: \(singlePlant.coolFact)", forState: UIControlState.Normal)
        moreFactsButton.setTitle("More Facts: \(singlePlant.moreFacts)", forState: UIControlState.Normal)
        
        let receivedData = singlePlant.image
        
        let imageData = NSData(base64EncodedString: receivedData, options: NSDataBase64DecodingOptions(rawValue: 0))
        let image = UIImage(data: imageData!)
        
        plantImage.image = image
    }
    
    
    @IBAction func textToSpeech(sender: UIButton) {
        if !synth.speaking{
            if sender.tag == 0 {
                myUtterance = AVSpeechUtterance(string: plantNameButton.titleLabel!.text!)
            }
            if sender.tag == 1 {
                myUtterance = AVSpeechUtterance(string: locationButton.titleLabel!.text!)
            }
            if sender.tag == 2 {
                myUtterance = AVSpeechUtterance(string: originButton.titleLabel!.text!)
            }
            if sender.tag == 3 {
                myUtterance = AVSpeechUtterance(string: whenToPlantButton.titleLabel!.text!)
            }
            if sender.tag == 4 {
                myUtterance = AVSpeechUtterance(string: coolFactButton.titleLabel!.text!)
            }
            if sender.tag == 5 {
                myUtterance = AVSpeechUtterance(string: moreFactsButton.titleLabel!.text!)
            }
            
            myUtterance.rate = 0.5
            synth.speakUtterance(myUtterance)
        }
        else{
            synth.continueSpeaking()
        }
    }
    
    func customButtons() {
        plantNameButton.contentEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        plantNameButton.titleLabel?.textColor = UIColor.whiteColor()
        plantNameButton.backgroundColor = UIColor.greenColor()
        plantNameButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 30)
        plantNameButton.layer.cornerRadius = 8
        plantNameButton.layer.borderWidth = 2
        plantNameButton.layer.borderColor = UIColor.blackColor().CGColor
        
        locationButton.contentEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        locationButton.titleLabel?.textColor = UIColor.whiteColor()
        locationButton.backgroundColor = UIColor.greenColor()
        locationButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 12)
        locationButton.layer.cornerRadius = 8
        locationButton.layer.borderWidth = 2
        locationButton.layer.borderColor = UIColor.blackColor().CGColor
        
        originButton.contentEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        originButton.titleLabel?.textColor = UIColor.whiteColor()
        originButton.backgroundColor = UIColor.greenColor()
        originButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 12)
        originButton.layer.cornerRadius = 8
        originButton.layer.borderWidth = 2
        originButton.layer.borderColor = UIColor.blackColor().CGColor
        
        whenToPlantButton.contentEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        whenToPlantButton.titleLabel?.textColor = UIColor.whiteColor()
        whenToPlantButton.backgroundColor = UIColor.greenColor()
        whenToPlantButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 12)
        whenToPlantButton.layer.cornerRadius = 8
        whenToPlantButton.layer.borderWidth = 2
        whenToPlantButton.layer.borderColor = UIColor.blackColor().CGColor
        
        coolFactButton.contentEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        coolFactButton.titleLabel?.textColor = UIColor.whiteColor()
        coolFactButton.backgroundColor = UIColor.greenColor()
        coolFactButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 12)
        coolFactButton.layer.cornerRadius = 8
        coolFactButton.layer.borderWidth = 2
        coolFactButton.layer.borderColor = UIColor.blackColor().CGColor
        
        moreFactsButton.contentEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        moreFactsButton.titleLabel?.textColor = UIColor.whiteColor()
        moreFactsButton.backgroundColor = UIColor.greenColor()
        moreFactsButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 12)
        moreFactsButton.layer.cornerRadius = 8
        moreFactsButton.layer.borderWidth = 2
        moreFactsButton.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    
    
}
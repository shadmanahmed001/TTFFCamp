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
    @IBOutlet weak var descriptionButton: UIButton!
    @IBOutlet weak var whenToPlantButton: UIButton!
    @IBOutlet weak var coolFactButton: UIButton!
    @IBOutlet weak var moreFactsButton: UIButton!
    @IBOutlet weak var plantImage: UIImageView!

    @IBOutlet weak var originTextLabel: UILabel!
    @IBOutlet weak var locationTextLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var whenToPlantTextLabel: UILabel!
    @IBOutlet weak var coolFactTextLabel: UILabel!
    @IBOutlet weak var moreFactsTextLabel: UILabel!
    
    
    
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
        originTextLabel.text = singlePlant.origin
        originTextLabel.numberOfLines = 0
        locationTextLabel.text = singlePlant.location
        locationTextLabel.numberOfLines = 0
        descriptionTextLabel.text = singlePlant.plantDescription
        descriptionTextLabel.numberOfLines = 0
        whenToPlantTextLabel.text = singlePlant.whenToPlant
        whenToPlantTextLabel.numberOfLines = 0
        coolFactTextLabel.text = singlePlant.coolFact
        coolFactTextLabel.numberOfLines = 0
        moreFactsTextLabel.text = singlePlant.moreFacts
        moreFactsTextLabel.numberOfLines = 0
        
        
        
        let receivedData = singlePlant.image
        
        let imageData = NSData(base64EncodedString: receivedData, options: NSDataBase64DecodingOptions(rawValue: 0))
        let image = UIImage(data: imageData!)
        
        plantImage.image = image
        plantImage.layer.borderWidth = 3
        plantImage.layer.borderColor = UIColor.greenColor().CGColor
    }
    
    
    @IBAction func textToSpeech(sender: UIButton) {
        if !synth.speaking{
            if sender.tag == 0 {
                myUtterance = AVSpeechUtterance(string: plantNameButton.titleLabel!.text!)
            }
            if sender.tag == 1 {
                myUtterance = AVSpeechUtterance(string: "Origin: \(singlePlant.origin)")
            }
            if sender.tag == 2 {
                myUtterance = AVSpeechUtterance(string: "Location: \(singlePlant.location)")
            }
            if sender.tag == 3 {
                myUtterance = AVSpeechUtterance(string: "Description: \(singlePlant.plantDescription)")
            }
            if sender.tag == 4 {
                myUtterance = AVSpeechUtterance(string: "When To Plant: \(singlePlant.whenToPlant)")
            }
            if sender.tag == 5 {
                myUtterance = AVSpeechUtterance(string: "Cool Fact: \(singlePlant.coolFact)")
            }
            if sender.tag == 6 {
                myUtterance = AVSpeechUtterance(string: "More Facts: \(singlePlant.moreFacts)")
            }
            
            myUtterance.rate = 0.5
            synth.speakUtterance(myUtterance)
        }
        else{
            synth.continueSpeaking()
        }
    }
    
    func customButtons() {
        plantNameButton.titleLabel?.textColor = UIColor.greenColor()
        plantNameButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 40)
        plantNameButton.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        plantNameButton.titleLabel?.textAlignment = NSTextAlignment.Center
        
        originButton.contentEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        originButton.backgroundColor = UIColor.lightGrayColor()
        originButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 20)
        originButton.layer.cornerRadius = 8
        originButton.layer.borderWidth = 2
        originButton.layer.borderColor = UIColor.blackColor().CGColor
        
        locationButton.contentEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        locationButton.backgroundColor = UIColor.lightGrayColor()
        locationButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 20)
        locationButton.layer.cornerRadius = 8
        locationButton.layer.borderWidth = 2
        locationButton.layer.borderColor = UIColor.blackColor().CGColor
        
        descriptionButton.contentEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        descriptionButton.backgroundColor = UIColor.lightGrayColor()
        descriptionButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 20)
        descriptionButton.layer.cornerRadius = 8
        descriptionButton.layer.borderWidth = 2
        descriptionButton.layer.borderColor = UIColor.blackColor().CGColor
        
        whenToPlantButton.contentEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        whenToPlantButton.backgroundColor = UIColor.lightGrayColor()
        whenToPlantButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 16)
        whenToPlantButton.layer.cornerRadius = 8
        whenToPlantButton.layer.borderWidth = 2
        whenToPlantButton.layer.borderColor = UIColor.blackColor().CGColor
        
        coolFactButton.contentEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        coolFactButton.backgroundColor = UIColor.lightGrayColor()
        coolFactButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 20)
        coolFactButton.layer.cornerRadius = 8
        coolFactButton.layer.borderWidth = 2
        coolFactButton.layer.borderColor = UIColor.blackColor().CGColor
        
        moreFactsButton.contentEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        moreFactsButton.backgroundColor = UIColor.lightGrayColor()
        moreFactsButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 20)
        moreFactsButton.layer.cornerRadius = 8
        moreFactsButton.layer.borderWidth = 2
        moreFactsButton.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    
    
}
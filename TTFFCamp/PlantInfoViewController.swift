//
//  PlantInfoViewController.swift
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
    @IBOutlet weak var plantImage: UIImageView!
    
    @IBOutlet weak var originTextLabel: UILabel!
    @IBOutlet weak var locationTextLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var whenToPlantTextLabel: UILabel!
    @IBOutlet weak var coolFactsTextView: UITextView!
    
    
    //MARK: NSSpeech
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
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
        // loop through all plants in the local database to find the specific plant scanned or chosen from the list
        for i in 0 ..< allPlants.count {
            if allPlants[i].plantName == plantName {
                print("found the correct plant ID", allPlants[i])
                singlePlant = allPlants[i]
                print(singlePlant.plantName)
                
            }
        }
        
        // Set UILabel properties of a single plant from database
        plantNameButton.setTitle(singlePlant.plantName, forState: UIControlState.Normal)
        originTextLabel.text = singlePlant.origin
        originTextLabel.numberOfLines = 0
        locationTextLabel.text = singlePlant.location
        locationTextLabel.numberOfLines = 0
        descriptionTextView.text = singlePlant.plantDescription
        whenToPlantTextLabel.text = singlePlant.whenToPlant
        whenToPlantTextLabel.numberOfLines = 0
        coolFactsTextView.text = singlePlant.coolFact
        descriptionTextView.editable = false;
        coolFactsTextView.editable = false;

        
        
        // Received image data comes in as Base64 string
        let receivedData = singlePlant.image
        
        // Decode Base64 string into NSData
        let imageData = NSData(base64EncodedString: receivedData, options: NSDataBase64DecodingOptions(rawValue: 0))
        
        // Set image variable to UIImage from raw data
        let image = UIImage(data: imageData!)
        
        // Set layout parameters for image
        plantImage.image = image
        plantImage.layer.borderWidth = 3
        plantImage.layer.borderColor = UIColor.greenColor().CGColor
    }
    
    // Function for text-to-speech
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
            
            myUtterance.rate = 0.5
            synth.speakUtterance(myUtterance)
        }
        else{
            synth.continueSpeaking()
        }
    }
    
    // Formatting of the buttons used for text-to-speech
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
        
    }
    
    
    
}
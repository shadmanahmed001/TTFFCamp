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

func getDocumentsURL() -> NSURL {
    let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
    print("getDocumentsURL", documentsURL)
    
    let filemgr = NSFileManager.defaultManager()
    if filemgr.fileExistsAtPath("/Applications") {
        print("File exists", filemgr.description)
        
    } else {
        print("File not found", filemgr)
    }
    
    return documentsURL
}

func fileInDocumentsDirectory(filename: String) -> String {
    
    let fileURL = getDocumentsURL().URLByAppendingPathComponent(filename)
    return fileURL.path!
    
}


class PlantInfoViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var plantTitleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var whenToPlantLabel: UILabel!
    @IBOutlet weak var coolFactLabel: UILabel!
    @IBOutlet weak var moreFactsLabel: UILabel!
    @IBOutlet weak var plantImageView: UIImageView!
    
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
    
    var plantObj = Plant()
    
    
    var detectedText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        // Test:  get all plant from fake service
        let plants = Database.all()
        
        print("Get all plants", plants)
        
        for var i = 0; i < plants.count; i++ {
            if plants[i].plantName == detectedText {
                print("found the correct plant ID", plants[i])
                plantObj = plants[i]
            }
        }
        
//        getPlantById(Int(detectedText)!)
        
//        plantObj = retrievePlant(detectedText)
        plantTitleLabel.text = plantObj.plantName
        locationLabel.text = "Location: \(plantObj.location)"
        originLabel.text = "Origin: \(plantObj.origin)"
        whenToPlantLabel.text = "When To Plant: \(plantObj.whenToPlant)"
        coolFactLabel.text = "Cool Fact: \(plantObj.coolFact)"
        moreFactsLabel.text = "More Facts: \(plantObj.moreFacts)"
        
        // Get Doc URL path to image file
        
        getDocumentsURL()
        
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)    
        self.navigationItem.setHidesBackButton(editing, animated: animated)
    }
    
    
    @IBAction func textToSpeech(sender: UIButton) {
        if !synth.speaking{
            myUtterance = AVSpeechUtterance(string: plantTitleLabel.text! )
            myUtterance.rate = 0.5
            synth.speakUtterance(myUtterance)
        }
        else{
            synth.continueSpeaking()
        }
    }
    
    
}
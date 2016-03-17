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
        
        plantNameButton.contentEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        locationButton.contentEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        originButton.contentEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        whenToPlantButton.contentEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        coolFactButton.contentEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        moreFactsButton.contentEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        
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
    

    
    
    
}
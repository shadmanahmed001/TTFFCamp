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
    
    @IBOutlet weak var plantTitleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var whenToPlantLabel: UILabel!
    @IBOutlet weak var coolFactLabel: UILabel!
    @IBOutlet weak var moreFactsLabel: UILabel!
    @IBOutlet weak var imagesLabel: UILabel!
    
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
    
    var singlePlant = Plant()
    var allPlants: [Plant] = []
    
    var detectedText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
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
            }
        }
        
        plantTitleLabel.text = singlePlant.plantName
        locationLabel.text = "Location: \(singlePlant.location[0] as? String)"
        originLabel.text = "Origin: \(singlePlant.origin)"
        whenToPlantLabel.text = "When To Plant: \(singlePlant.whenToPlant)"
        coolFactLabel.text = "Cool Fact: \(singlePlant.coolFact)"
        moreFactsLabel.text = "More Facts: \(singlePlant.moreFacts[0] as? String)"
        imagesLabel.text = "Image Names: \(singlePlant.images[0] as? String)"
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
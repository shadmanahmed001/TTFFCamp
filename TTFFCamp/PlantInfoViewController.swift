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
    @IBOutlet weak var imagesNamesLabel: UILabel!

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

        plantNameButton.setTitle(singlePlant.plantName, forState: UIControlState.Normal)
        locationButton.setTitle("Location: \(singlePlant.locations[0] as! String)", forState: UIControlState.Normal)
        originButton.setTitle("Origin: \(singlePlant.origin)", forState: UIControlState.Normal)
        whenToPlantButton.setTitle("When To Plant: \(singlePlant.whenToPlant)", forState: UIControlState.Normal)
        coolFactButton.setTitle("Cool Fact: \(singlePlant.coolFact)", forState: UIControlState.Normal)
        moreFactsButton.setTitle("More Facts: \(singlePlant.moreFacts)", forState: UIControlState.Normal)
        imagesNamesLabel.text = "Image Names: \(singlePlant.images[0] as? String)"
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
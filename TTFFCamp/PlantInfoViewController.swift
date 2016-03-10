//
//  plantInfoViewController.swift
//  TTFFCamp
//
//  Created by yanze on 3/9/16.
//  Copyright © 2016 The Taylor Family Foundation. All rights reserved.
//

import UIKit
import AVFoundation

class PlantInfoViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var qrCodeLabel: UILabel!
    @IBOutlet weak var detectedTextView: UITextView!
    
    var detectedText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detectedTextView.text = detectedText
    }
   
    
}
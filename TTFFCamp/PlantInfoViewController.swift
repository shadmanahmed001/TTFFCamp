//
//  plantInfoViewController.swift
//  TTFFCamp
//
//  Created by yanze on 3/9/16.
//  Copyright © 2016 The Taylor Family Foundation. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

class PlantInfoViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var qrCodeLabel: UILabel!
    @IBOutlet weak var detectedTextView: UITextView!
    
    var detectedText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detectedTextView.text = detectedText
        
        
        Alamofire.request(.GET, "https://api.github.com/users/yanze")
            .responseJSON { response in
                //                print(response.request)  // original URL request
                //                print(response.response) // URL response
                //                print(response.data)     // server data
                //                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    self.detectedTextView.text = "\(JSON)!"
                }
        }
    }
   
    
}
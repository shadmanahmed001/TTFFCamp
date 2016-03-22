//
//  QRReaderViewController.swift
//  TTFFCamp
//
//  Created by yanze on 3/9/16.
//  Copyright © 2016 The Taylor Family Foundation. All rights reserved.
//

import UIKit
import AVFoundation

class QRReaderViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    
    @IBOutlet weak var welcomeBannerLabel: UILabel!
    var objCaptureSession: AVCaptureSession?
    var objCaptureVideoPreviewLayer: AVCaptureVideoPreviewLayer?
    var vwQRCode: UIView?
    var detectedText = ""
    
    @IBOutlet weak var planListButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureVideoCapture()
        self.addVideoPreviewLayer()
        self.initializeQRView()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.navigationItem.setHidesBackButton(editing, animated: animated)
    }
    
    
    func configureVideoCapture() {
        
        let objCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error: NSError?
        
        let objCaptureDeviceInput: AnyObject!
        
        do {
            objCaptureDeviceInput = try AVCaptureDeviceInput(device: objCaptureDevice) as AVCaptureDeviceInput
        } catch let error1 as NSError {
            error = error1
            objCaptureDeviceInput = nil
        }
        
        if (error != nil) {
            let alertController:UIAlertController = UIAlertController(title: "Device Error", message: "Device not Supported for this Application", preferredStyle: .Alert)
            
            let cancelAction:UIAlertAction = UIAlertAction(title: "Ok Done", style: .Cancel, handler: { (alertAction) -> Void in
                alertController.dismissViewControllerAnimated(true, completion: nil)
            })
            
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
        
        objCaptureSession = AVCaptureSession()
        
        objCaptureSession?.addInput(objCaptureDeviceInput as! AVCaptureInput)
        
        let objCaptureMetadataOutput = AVCaptureMetadataOutput()
        objCaptureSession?.addOutput(objCaptureMetadataOutput)
        
        
        objCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        objCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
    }
    
    func addVideoPreviewLayer() {
        objCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: objCaptureSession)
        objCaptureVideoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        objCaptureVideoPreviewLayer?.frame = view.layer.bounds
        self.view.layer.addSublayer(objCaptureVideoPreviewLayer!)
        objCaptureSession?.startRunning()
        customBanner()
        customPlantListButton()
        self.view.bringSubviewToFront(welcomeBannerLabel)
        self.view.bringSubviewToFront(planListButton)

    }
    
    func initializeQRView() {
        vwQRCode = UIView()
        vwQRCode?.layer.borderColor = UIColor.greenColor().CGColor
        vwQRCode?.layer.borderWidth = 5
        self.view.addSubview(vwQRCode!)
        self.view.bringSubviewToFront(vwQRCode!)
    }
    
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        if metadataObjects == nil || metadataObjects.count == 0 {
            vwQRCode?.frame = CGRectZero
            return
        }
        let objMetadataMachineReadableCodeObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if objMetadataMachineReadableCodeObject.type == AVMetadataObjectTypeQRCode {
            let objBarCode = objCaptureVideoPreviewLayer?.transformedMetadataObjectForMetadataObject(objMetadataMachineReadableCodeObject as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            vwQRCode?.frame = objBarCode.bounds;
            if objMetadataMachineReadableCodeObject.stringValue != nil {
                detectedText = objMetadataMachineReadableCodeObject.stringValue
                objCaptureSession?.stopRunning()
                self.performSegueWithIdentifier("showInfo", sender: nil)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier! == "showInfo"){
            let plantInfoVC = segue.destinationViewController as! PlantInfoViewController
            plantInfoVC.detectedText = detectedText
        }
    }
    
    func customBanner() {
        welcomeBannerLabel.layer.backgroundColor = UIColor.greenColor().CGColor
        welcomeBannerLabel.textColor = UIColor.whiteColor()
        welcomeBannerLabel.layer.cornerRadius = 10
        welcomeBannerLabel.font = UIFont(name: "Chalkduster", size: 45)
        welcomeBannerLabel.layer.borderWidth = 2
        welcomeBannerLabel.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    
    @IBAction func clickToPlantList(sender: UIButton) {
        
    }
    
    func customPlantListButton(){
        planListButton.layer.backgroundColor = UIColor.greenColor().CGColor
        planListButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        planListButton.layer.cornerRadius = 10
        planListButton.titleLabel!.font =  UIFont(name: "Chalkduster", size: 36)
        planListButton.layer.borderWidth = 2
        planListButton.layer.borderColor = UIColor.whiteColor().CGColor
    }

    

    
}


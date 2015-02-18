//
//  ViewController.swift
//  touchIDExample
//
//  Created by Dario Fanjul on 7/2/15.
//  Copyright (c) 2015 Dario Fanjul. All rights reserved.
//

import UIKit

import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func authenticatePressed(sender: AnyObject) {
        let context = LAContext()
        var error : NSError?
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "Is you the owner?", reply: { [weak self] (success: Bool, error: NSError!) -> Void in
                
                if let strongSelf = self {
                    if success {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            strongSelf.statusLabel.text = "Great! It passed"
                        })
                        println("Passed!")
                    } else {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            strongSelf.statusLabel.text = error.localizedDescription
                        })
                        println("Error: \(error.localizedDescription)")
                    }
                }
            })
        
        } else {
            statusLabel.text = "Device with no touchID"
        }
    }

}


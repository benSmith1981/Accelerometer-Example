//
//  ViewController.swift
//  Accelerometer-Example
//
//  Created by Ben Smith on 28/01/17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit
import CoreMotion

class AcclerometerRawData: UIViewController {

    @IBOutlet weak var uprightImage: UIImageView!
    
    //get cmmotion manager
    let manager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        if manager.isGyroAvailable {
            checkAngle()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func checkAngle() {
        if manager.isAccelerometerAvailable {
            manager.accelerometerUpdateInterval = 0.01 //set fast uprdate for image
            manager.startAccelerometerUpdates(to: OperationQueue.main) {
                [weak self] (data: CMAccelerometerData?, error: Error?) in
                if let acceleration = data?.acceleration {
                    let rotation = atan2(acceleration.x, acceleration.y) - M_PI
                    self?.uprightImage.transform = CGAffineTransform(rotationAngle: CGFloat(rotation))
                }
            }
        }
    }
}


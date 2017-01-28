//
//  CompassVC.swift
//  Accelerometer-Example
//
//  Created by Ben Smith on 28/01/17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit
import CoreMotion
class CompassVC: UIViewController {
    @IBOutlet weak var uprightImage: UIImageView!

    //get cmmotion manager
    let manager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        if manager.isMagnetometerAvailable {
            
            moveCompass()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func moveCompass(){
        manager.deviceMotionUpdateInterval = 0.01
        manager.startMagnetometerUpdates(to: OperationQueue.main) {[weak self] (compassData, error) in
            if let compass = compassData?.magneticField {
                let rotation = atan2(compass.z, compass.y) - M_PI
                self?.uprightImage.transform = CGAffineTransform(rotationAngle: CGFloat(rotation))
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

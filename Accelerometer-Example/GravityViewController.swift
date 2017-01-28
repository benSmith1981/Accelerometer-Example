//
//  GravityViewController.swift
//  Accelerometer-Example
//
//  Created by Ben Smith on 28/01/17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit
import  CoreMotion
class GravityViewController: UIViewController,
                             UINavigationControllerDelegate{

    @IBOutlet weak var uprightImage: UIImageView!
    
    //get cmmotion manager
    let manager = CMMotionManager()
    let clunkManager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        //check if certain feature of core motion is there...
        if manager.isGyroAvailable && manager.isDeviceMotionAvailable {
            rotate()
        }

        
        if manager.isDeviceMotionAvailable {
            clunkDetect()
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rotate(){
        manager.deviceMotionUpdateInterval = 0.01
        manager.startDeviceMotionUpdates(to: OperationQueue.main) { [weak self] (data, error) in
            if let gravity = data?.gravity {
                let rotation = atan2(gravity.x, gravity.y) - M_PI
                self?.uprightImage.transform = CGAffineTransform(rotationAngle: CGFloat(rotation))
            }
        }
    }
    
    func clunkDetect(){
            clunkManager.deviceMotionUpdateInterval = 0.02
            clunkManager.startDeviceMotionUpdates(to: OperationQueue.main) {
                [weak self] (data: CMDeviceMotion?, error: Error?) in
                
                if let x = data?.userAcceleration.x,
                    x < -2.5 {
                    let _ = self?.navigationController?.popViewController(animated: true)
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

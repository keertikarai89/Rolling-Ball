//
//  ViewController.swift
//  Assignment2
//
//  Created by Keertika on 5/16/18.
//  Copyright © 2018 Keertika. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet var ball: Ball!
    @IBOutlet weak var score: UILabel!
    
    let motionManager = CMMotionManager() // must be declared as a property
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ball.start()
    
        motionManager.deviceMotionUpdateInterval = 1/10
        let queue = OperationQueue()
        
        if motionManager.isDeviceMotionAvailable {
            motionManager.startDeviceMotionUpdates(to: queue) { data, error in
                if let data = data {
                    
                    self.ball.velocity = CGFloat(( (data.userAcceleration.x * data.userAcceleration.x) + (data.userAcceleration.y * data.userAcceleration.y) ).squareRoot())
                    
                    self.ball.velocity = 4 + 100 * self.ball.velocity
                    
                    self.ball.dx = CGFloat(data.gravity.x)
                    self.ball.dy = -CGFloat(data.gravity.y)
                }
                
                DispatchQueue.main.async {
                    //let scoreDifference = Data().count
                    self.score.text = String(format: "Score: %d", self.ball.score)
                }
            }
        } else {
            print("Device motion not available")
            print("Device motion not available")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
        if motionManager.isDeviceMotionActive {
            motionManager.stopDeviceMotionUpdates()
        }
        //restart.isHidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var shouldAutorotate: Bool { return false }
    
}

//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var hugeTopLabel: UILabel!
    
    //    let softTime = 5
    //    let mediumTime = 7
    //    let hardTime = 12
    
    let eggTimeInMinutes : [String:Int] = [
        "Soft" : 5,
        "Medium" : 7,
        "Hard" : 12
    ]
    
    var scheduledTimer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton){
        
        let hardness = sender.currentTitle
        
        var timeToBoilInSeconds = (eggTimeInMinutes[hardness ?? "Hard"] ?? 60) * 60
        self.hugeTopLabel.text = "Your egg will boil \(timeToBoilInSeconds) seconds!"
        scheduledTimer.invalidate()
        
        scheduledTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true)
        {
            (Timer) in
            if timeToBoilInSeconds > 0 {
                print ("\(timeToBoilInSeconds) seconds")
                timeToBoilInSeconds -= 1
            } else {
                Timer.invalidate()
                self.hugeTopLabel.text = "DONE!"
            }
        }
        
    }
    
}

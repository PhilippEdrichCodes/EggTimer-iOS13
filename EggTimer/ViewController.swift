//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var hugeTopLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var scheduledTimer: Timer = Timer()
    var player: AVAudioPlayer!
    
    var timeInSeconds = 0
    var secondsPassed = 0

    let eggTimeInMinutes : [String:Int] = [
        "Soft" : 5,
        "Medium" : 7,
        "Hard" : 12
    ]
    
    override func viewDidLoad() {
        
        // reset the progressbar
        progressBar.progress = 0.0
        
        // initialize scheduledTimer
        scheduledTimer = Timer()
        
        // make sure the Label shows what it should
        hugeTopLabel.text = "How do you like your eggs?"
    }

    @IBAction func hardnessSelected(_ sender: UIButton){
        
        //reset secondsPassed
        secondsPassed = 0
        // make sure the timer is reset before it get started
        scheduledTimer.invalidate()
        
        // initialize the progress done
        var percentageProgress : Float = 0.0
        
        // get the wanted hardness as String from the buttonLabel
        let hardness = sender.currentTitle ?? "Hard"
        // get the time out of the Dictionary
        let timeToBoilinMinutes = (eggTimeInMinutes[hardness] ?? 5)
        // calculate the needed seconds
        timeInSeconds = timeToBoilinMinutes * 60
        
        // tell the user how long he will have to wait
        self.hugeTopLabel.text = "Your egg will boil \(timeToBoilinMinutes) minutes!"
        
        // initiate the  progressbar
        progressBar.progress = percentageProgress
        
        //start the timer
        scheduledTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true)
        {
            (Timer) in
            // the timer shall run as long as needed
            if self.secondsPassed < self.timeInSeconds {
                // increase secondsPassed
                self.secondsPassed += 1
                // calculate the percentage already done
                percentageProgress = Float(self.secondsPassed)/Float(self.timeInSeconds)
                // update the progress bar
                self.progressBar.setProgress(percentageProgress, animated: true)
            }
            // when secondsPassed = timeInSecond it comes to an end
            else {
                // make sure the progress bar is filled
                self.progressBar.setProgress(1.0, animated: true)
                // end the timer
                Timer.invalidate()
                // get the attention of the user to ...
                self.playAlarm()
                // ... tell the user the eggs are ready
                self.hugeTopLabel.text = "DONE!"
            }
        }
        
    }
    
    func playAlarm() {
        // get the path to the file
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        // load the audio into the player
        player = try! AVAudioPlayer(contentsOf: url!)
        // play the sound
        player.play()
    }
    
}

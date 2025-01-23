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
    var countdownTimer: Timer!
    var totalTime = 0
    var secondsPassed = 0
    let eggTimes = ["Soft" : 1, "Medium" : 2, "Hard" : 3]
    var player: AVAudioPlayer?
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }

    func startTimer() {
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true) }
    
    @IBOutlet weak var progresBar: UIProgressView!
    @objc func updateTime() {
        print( secondsPassed )
            if secondsPassed < totalTime {
                secondsPassed += 1
                let percentageProgress = Float(secondsPassed) / Float(totalTime)
                progresBar.progress = Float(percentageProgress)

            } else {
                endTimer()
            }
        }

    func timeFormatted(_ totalMinutes: Int) -> String {
        //let seconds: Int = totalMinutes % 60
        let minutes: Int = (totalMinutes)
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d", minutes)
    }
    
        func endTimer() {
            playSound()
            progresBar.progress = 0.0
            secondsPassed = 0
            print("Done")
            countdownTimer.invalidate()
            
        }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle
        for egg in eggTimes{
            if(hardness! == egg.key){
                totalTime = (egg.value * 60)
                }
            startTimer()
            

        }
    }
}


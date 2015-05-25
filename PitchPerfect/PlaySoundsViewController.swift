//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/18/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import UIKit
import AVFoundation

public protocol PlaySoundsDelegate {
    
    func initializePlayer(audio: RecordedAudio)
}

public class PlaySoundsViewController: UIViewController, PlaySoundsDelegate {
    
    // TODO: Learn more about strong and weak references in Swift/iOS.
    var player: AVAudioPlayer?
    
    @IBOutlet public weak var slowMoButtom: UIButton!
    @IBOutlet public weak var chipmunkButton: UIButton!
    
    @IBAction func playSlowMo(sender: UIButton, forEvent event: UIEvent) {
        self.playAudio(Float(0.5))
    }
    
    @IBAction func playFastMo(sender: UIButton, forEvent event: UIEvent) {
        self.playAudio(Float(3.0))
    }
    
    @IBAction func stopButton(sender: UIButton, forEvent event: UIEvent) {
        self.stopAudio()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton, forEvent event: UIEvent) {
    }
    
    public func initializePlayer(audio: RecordedAudio) {
        // TODO: Should we dealloc/nullify the player if there is already an instance?
        self.player = AVAudioPlayer(contentsOfURL: audio.filePath, error: nil)
        
        // Enable variable audio playback rate
        self.player?.enableRate = true
    }
    
    func stopAudio() {
        self.player?.stop()
        self.player?.currentTime = 0.0
    }
    
    func playAudio(rate: Float) {
        self.stopAudio()
        self.player?.rate = rate
        self.player?.play()
    }
}
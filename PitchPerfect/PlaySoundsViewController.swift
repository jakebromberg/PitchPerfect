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
    private let audioService: AudioPlaybackService = AudioPlaybackService()
    
    @IBOutlet public weak var fastMoButton: UIButton!
    @IBOutlet public weak var slowMoButtom: UIButton!
    @IBOutlet public weak var chipmunkButton: UIButton!
    @IBOutlet public weak var darthVaderButton: UIButton!
    
    @IBAction func playDarthVader(sender: UIButton, forEvent event: UIEvent) {
        audioService.play(.DarthVader)
    }
    
    @IBAction func playSlowMo(sender: UIButton, forEvent event: UIEvent) {
        audioService.play(.SlowMo)
    }
    
    @IBAction func playFastMo(sender: UIButton, forEvent event: UIEvent) {
        audioService.play(.FastMo)
    }
    
    @IBAction func stopButton(sender: UIButton, forEvent event: UIEvent) {
        audioService.stop()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton, forEvent event: UIEvent) {
        audioService.play(.Chipmunk)
    }
    
    public func initializePlayer(audio: RecordedAudio) {
        // TODO: Should we dealloc/nullify the service if there is already an instance?
        audioService.prepare(audio.filePath)
    }
}

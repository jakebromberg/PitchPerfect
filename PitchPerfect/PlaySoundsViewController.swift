//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/18/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import UIKit
import AVFoundation

public class PlaySoundsViewController: UIViewController {
    
    // TODO: Learn more about strong and weak references in Swift/iOS.
    var player: AVAudioPlayer?
    
    @IBOutlet public var slowMoButtom: UIButton!
    
    @IBAction func playSlowMo(sender: UIButton, forEvent event: UIEvent) {
        self.playAudio(Float(0.5))
    }
    
    @IBAction func playFastMo(sender: UIButton, forEvent event: UIEvent) {
        self.playAudio(Float(3.0))
    }
    
    @IBAction func stopButton(sender: UIButton, forEvent event: UIEvent) {
        self.stopAudio()
    }
    
    func initializePlayer(resource: NSURL!) {
        self.player = AVAudioPlayer(contentsOfURL: resource, error: nil)
    }
    
    func stopAudio() {
        self.player?.stop()
        self.player?.currentTime = 0.0
    }
    
    func playAudio(rate: Float) {
        self.ensurePlayerReady()
        self.stopAudio()
        self.player?.rate = rate
        self.player?.play()
    }
    
    func ensurePlayerReady() {
        // Instantiate the player once and only once
        if self.player != nil {
            return
        }
        
        // Assembly an adhoc delegate to fetch the resource from bundle
        let fetchMovieQuote: FetchBundleResourceDelegate = (
            ok: self.initializePlayer,
            notfound: self.noMovieQuote
        )
        
        // Fetch the actual resource
        fetchResource("movie_quote", withExtension: "mp3", delegate: fetchMovieQuote)
        
        // Enable variable audio playback rate
        self.player?.enableRate = true
    }
    
    // Handles the case when the corresponding resource has not been found in the main bundle
    func noMovieQuote() {
        println("not found the requested movie quote resource...")
    }
}
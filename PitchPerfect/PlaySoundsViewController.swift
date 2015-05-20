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
    var player: AVAudioPlayer!
    
    @IBOutlet public var slowMoButtom: UIButton!
    
    @IBAction func playSlowMo(sender: UIButton, forEvent event: UIEvent) {
        // Assembly an adhoc delegate to fetch the resource from bundle
        let fetchMovieQuote: FetchBundleResourceDelegate = (
            ok: self.playMovieQuote,
            notfound: self.noMovieQuote
        )
        
        // Fetch the actual resource
        fetchResource("movie_quote", withExtension: "mp3", delegate: fetchMovieQuote)
    }
    
    // Plays movie quote if the corresponding resource has been found in the main bundle
    func playMovieQuote(resource: NSURL!) {
        self.player = AVAudioPlayer(contentsOfURL: resource, error: nil)
        self.player.play()
    }
    
    // Handles the case when the corresponding resource has not been found in the main bundle
    func noMovieQuote() {
        println("not found the requested movie quote resource...")
    }
}
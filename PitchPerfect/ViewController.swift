//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/10/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import UIKit

public class ViewController: UIViewController {

    // TODO: Remove extra outlets when Swift begins to support TDD
    @IBOutlet public weak var recordButton: UIButton!
    @IBOutlet public weak var stopButton: UIButton!
    
    @IBOutlet public weak var recorderState: UILabel!
    
    @IBAction func recordAudio(sender: UIButton) {
        self.showRecordingInProgress()
    }
    
    @IBAction func stopRecording(sender: UIButton, forEvent event: UIEvent) {
        self.hideRecordingInProgress()
    }
    
    func hideRecordingInProgress() {
        self.recorderState.hidden = true
    }
    
    func showRecordingInProgress() {
        self.recorderState.hidden = false
    }
    
}


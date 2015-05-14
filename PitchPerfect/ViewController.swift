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
    
    @IBAction func tapRecordButton(sender: UIButton, forEvent event: UIEvent) {
        self.startRecording()
    }
    
    @IBAction func tapStopButton(sender: UIButton, forEvent event: UIEvent) {
        self.stopRecording()
    }
    
    func stopRecording() {
        self.recorderState.hidden = true
        self.recordButton.enabled = true
    }
    
    func startRecording() {
        self.recorderState.hidden = false
        self.recordButton.enabled = false
    }
    
}


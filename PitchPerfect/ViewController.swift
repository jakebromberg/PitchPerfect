//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/10/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var recorderState: UILabel!
    
    @IBAction func recordAudio(sender: UIButton) {
        self.showRecordingInProgress()
        
        // TODO: Record the user's voice
        println("in recordAudio")
    }
    
    @IBAction func stopRecording(sender: UIButton, forEvent event: UIEvent) {
        self.hideRecordingInProgress()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideRecordingInProgress() {
        self.recorderState.hidden = true
    }
    
    func showRecordingInProgress() {
        self.recorderState.hidden = false
    }
    
}


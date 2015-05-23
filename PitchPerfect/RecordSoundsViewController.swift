//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/10/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import UIKit

public class RecordSoundsViewController: UIViewController {
    
    var recordingService: AudioRecordingService = AudioRecordingService()

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
        self.stopButton.hidden = true
        self.recordButton.enabled = true
        
        // Stop the actual recording...
        self.recordingService.stop()
    }
    
    func startRecording() {
        self.recorderState.hidden = false
        self.stopButton.hidden = false
        self.recordButton.enabled = false
        
        // Start the actual recording...
        self.recordingService.start(self.doneWithRecording)
    }
    
    func doneWithRecording(record: RecordedAudio) {
        println("doneWithRecording -> " + record.filePath.path!)
        self.performSegueWithIdentifier("PlaySounds", sender: record)
    }
    
    public override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // No funny business with segue identifiers and etc.
        if let playSounds = segue.destinationViewController as? PlaySoundsDelegate {
            let record = sender as! RecordedAudio
            playSounds.initializePlayer(record.filePath)
        }
    }
}


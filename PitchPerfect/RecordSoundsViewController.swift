//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/10/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import UIKit

public class RecordSoundsViewController: UIViewController {
    
    var recordingService: AudioRecordingServiceProtocol = SampleAudioRecordingSerice()

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
        self.recordingService.start((
            done: self.doneWithRecording,
            fail: self.failedToRecordAudio
        ))
    }
    
    func doneWithRecording(record: RecordedAudio) {
        println("doneWithRecording -> " + record.filePath.path!)
        self.performSegueWithIdentifier("PlaySounds", sender: record)
    }
    
    func failedToRecordAudio() {
        // For now this is just a simple callback to adjust UI accordingly if something goes wrong
        println("Aww, snap! Good grief... something went wrong...")
        self.stopRecording()
    }
    
    public override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        super.prepareForSegue(segue, sender: sender)
        
        let destination: AnyObject = segue.destinationViewController
        
        // No funny business with segue identifiers and etc.
        if let playSounds = destination as? PlaySoundsDelegate {
            let record = sender as! RecordedAudio
            playSounds.initializePlayer(record)
            
            // TODO: Figure out how to use preprocessor directives in Swift, so we send notification only
            // when DEBUG preprocessor directive is set.
            
            // This trick is to notify the test runtime we reached certain point while executing the code
            // and it's not ideal, requires maintenance but testability is of top-notch priority.
            NSNotificationCenter.defaultCenter().postNotificationName("prepareForSegue:playSounds", object: destination)
        }
    }
    
    public override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(thisOrThat(animated, false))
    }
    
    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(thisOrThat(animated, false))
    }
}


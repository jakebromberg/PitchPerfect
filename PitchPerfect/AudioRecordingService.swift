//
//  AudioRecordingService.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/23/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import Foundation
import AVFoundation

public typealias AudioRecordingDoneDelegate = (RecordedAudio) -> Void
public typealias AudioRecordingFailDelegate = () -> Void

// Combined type alias for convenience and both fields are required
public typealias AudioRecordingDelegate = (
    done: AudioRecordingDoneDelegate,
    fail: AudioRecordingFailDelegate
)

// An abstraction layer on top of AudioRecordingService, so we could easily swap
// it with an implementation that fetches the data from resources for convenience when clicking thru the app.
public protocol AudioRecordingServiceProtocol {
    
    func start(delegate: AudioRecordingDelegate)
    func stop()
}

// Actual recording service that records & saves audio input to the file
class AudioRecordingService: NSObject, AVAudioRecorderDelegate, AudioRecordingServiceProtocol {
    
    private var delegate: AudioRecordingDelegate!
    private var audioRecorder: AVAudioRecorder!
    private var audioSession: AVAudioSession!
    
    func start(delegate: AudioRecordingDelegate) {
        // Keep reference to the callback
        self.delegate = delegate
        
        let folders = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let folderPath = folders.first as! String
        
        let today = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        
        let fileName = formatter.stringFromDate(today) + ".wav"
        let filePath = NSURL.fileURLWithPathComponents([folderPath, fileName])
        
        println("recording to this file ~> \(filePath)")
        
        audioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.record()
    }
    
    func stop() {
        // Stop recording and adjust the audio session state
        audioRecorder.stop()
        audioSession.setActive(false, error: nil)
    }
    
    private func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        // Send back the signal as we're done with the recording
        if (flag) {
            // Assemble an instance of the model
            let filePath = recorder.url
            let fileName = filePath.lastPathComponent!
            let record = RecordedAudio(title: fileName, filePath: filePath)
            
            // Notify the subscriber about recorded audio file availability
            delegate.done(record)
        } else {
            delegate.fail()
        }
    }
}

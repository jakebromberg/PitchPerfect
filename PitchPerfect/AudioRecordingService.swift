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

public class RecordedAudio: NSObject {
    var title: String!
    var filePath: NSURL!
}

class AudioRecordingService: NSObject, AVAudioRecorderDelegate {
    
    var delegate: AudioRecordingDelegate!
    var audioRecorder: AVAudioRecorder!
    var record: RecordedAudio!
    var audioSession: AVAudioSession!
    
    func start(delegate: AudioRecordingDelegate) {
        // Keep reference to the callback
        self.delegate = delegate
        
        let folders = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let folderPath = folders.first as! String
        
        let today = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        
        let fileName = formatter.stringFromDate(today) + ".wav"
        
        self.record = RecordedAudio()
        self.record.title = fileName
        self.record.filePath = NSURL.fileURLWithPathComponents([folderPath, fileName])
        println(self.record.filePath)
        
        self.audioSession = AVAudioSession.sharedInstance()
        self.audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        self.audioRecorder = AVAudioRecorder(URL: self.record.filePath, settings: nil, error: nil)
        self.audioRecorder.delegate = self
        self.audioRecorder.meteringEnabled = true
        self.audioRecorder.record()
    }
    
    func stop() {
        // Stop recording and adjust the audio session state
        self.audioRecorder.stop()
        self.audioSession.setActive(false, error: nil)
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        // Send back the signal as we're done with the recording
        if (flag) {
            self.delegate.done(self.record)
        } else {
            self.delegate.fail()
        }
    }
}
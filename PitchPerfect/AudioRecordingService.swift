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

public protocol AudioRecordingServiceProtocol {
    
    func start(delegate: AudioRecordingDelegate)
    func stop()
}

public class RecordedAudio: NSObject {
    var title: String!
    var filePath: NSURL!
}

// Sample recording service that mocks audio recording process and falls back to use "movie_quote.mp3" embedded resource.
class SampleAudioRecordingSerice: NSObject, AudioRecordingServiceProtocol {
    
    var delegate: AudioRecordingDelegate!
    
    func start(delegate: AudioRecordingDelegate) {
        self.delegate = delegate
        fetchResource("movie_quote", withExtension: "mp3", delegate: (
            ok: self.fetchFileFromResources,
            notfound: self.fileNotFound
        ))
    }
    
    func stop() {
        // nothing to do
    }
    
    private func fileNotFound() {
        println("file not found...")
        self.delegate.fail()
    }
    
    private func fetchFileFromResources(filePath: NSURL!) {
        var record = RecordedAudio()
        record.title = "Sample"
        record.filePath = filePath

        self.delegate.done(record)
    }
}

// Actual recording service that records & saves audio input to the file
class AudioRecordingService: NSObject, AVAudioRecorderDelegate, AudioRecordingServiceProtocol {
    
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
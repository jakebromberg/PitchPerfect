//
//  AudioRecordingService.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/23/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import Foundation
import AVFoundation

// Actual recording service that records & saves audio input to the file
final class AudioRecordingService: NSObject, AVAudioRecorderDelegate, AudioRecordingServiceProtocol {
    
    private var delegate: AudioRecordingCallback!
    private var audioRecorder: AVAudioRecorder!
    private var audioSession: AVAudioSession!
    
    func start() {

        let folders = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let folderPath = folders.first as! String
        
        let today = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        
        let fileName = formatter.stringFromDate(today) + ".wav"
        let filePath = NSURL.fileURLWithPathComponents([folderPath, fileName])
        
        audioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.record()
    }
    
    /// Stops recording, adjusts the audio session state and uses the delegate supplied to report back
    /// whether the recording is done or failed for any reason.
    func stop(delegate: AudioRecordingCallback) {
        
        // Keep reference to the callback
        self.delegate = delegate
        
        audioRecorder.stop()
        audioSession.setActive(false, error: nil)
        
        // Switch the category to be AVAudioSessionCategoryPlayback,
        // so the audio volume level is adequate (without this the playback of recorded audio barely could be heard).
        // Found the advice here: http://bit.ly/1JdTRXW
        audioSession.setCategory(AVAudioSessionCategoryPlayback, error: nil)
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        // Send back the signal as we're done with the recording
        if (flag) {
            // Assembly an instance of the model
            let record = RecordedAudio(
                title: recorder.url.lastPathComponent!,
                filePath: recorder.url)
            
            // Notify the subscriber about the recorded audio file availability
            delegate.done(record)
        } else {
            delegate.fail()
        }
    }
}

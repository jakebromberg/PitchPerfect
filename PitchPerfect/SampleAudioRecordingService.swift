//
//  SampleAudioRecordingService.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/26/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import Foundation

// Sample recording service that mocks audio recording process and falls back to use "movie_quote.mp3" embedded resource.
final class SampleAudioRecordingSerice: NSObject, AudioRecordingServiceProtocol {
    
    private var record: RecordedAudio?
    
    func start() {
        fetchResource("movie_quote", withExtension: "mp3", delegate: (
            ok: fetchFileFromResources,
            notfound: fileNotFound
        ))
    }
    
    func stop(delegate: AudioRecordingCallback) {
        if let resource = record {
            delegate.done(resource)
            return
        }
        
        delegate.fail()
    }
    
    private func fileNotFound() {
        // nothing to do...
    }
    
    private func fetchFileFromResources(filePath: NSURL!) {
        record = RecordedAudio(title: "Sample", filePath: filePath)
    }
}

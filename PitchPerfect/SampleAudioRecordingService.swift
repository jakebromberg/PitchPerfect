//
//  SampleAudioRecordingService.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/26/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import Foundation

// Sample recording service that mocks audio recording process and falls back to use "movie_quote.mp3" embedded resource.
class SampleAudioRecordingSerice: NSObject, AudioRecordingServiceProtocol {
    
    private var delegate: AudioRecordingDelegate!
    
    func start(delegate: AudioRecordingDelegate) {
        self.delegate = delegate
        fetchResource("movie_quote", withExtension: "mp3", delegate: (
            ok: fetchFileFromResources,
            notfound: fileNotFound
        ))
    }
    
    func stop() {
        // nothing to do
    }
    
    private func fileNotFound() {
        println("file not found...")
        delegate.fail()
    }
    
    private func fetchFileFromResources(filePath: NSURL!) {
        let record = RecordedAudio(title: "Sample", filePath: filePath)
        delegate.done(record)
    }
}

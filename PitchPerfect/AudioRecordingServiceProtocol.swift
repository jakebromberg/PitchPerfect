//
//  AudioRecordingServiceProtocol.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/27/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import Foundation

// An abstraction layer on top of AudioRecordingService, so we could easily swap
// it with an implementation that fetches the data from resources for convenience when clicking thru the app.
public protocol AudioRecordingServiceProtocol {
    
    func start()
    func stop(callback: AudioRecordingCallback)
}

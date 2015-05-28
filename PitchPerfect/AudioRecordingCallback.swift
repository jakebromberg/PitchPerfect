//
//  AudioRecordingDelegate.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/27/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import Foundation

public typealias AudioRecordingDoneCallback = (RecordedAudio) -> Void
public typealias AudioRecordingFailCallback = () -> Void

// Combined type alias for convenience and both fields are required
public typealias AudioRecordingCallback = (
    done: AudioRecordingDoneCallback,
    fail: AudioRecordingFailCallback
)

//
//  AudioRecordingDelegate.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/27/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import Foundation

public typealias AudioRecordingDoneDelegate = (RecordedAudio) -> Void
public typealias AudioRecordingFailDelegate = () -> Void

// Combined type alias for convenience and both fields are required
public typealias AudioRecordingDelegate = (
    done: AudioRecordingDoneDelegate,
    fail: AudioRecordingFailDelegate
)

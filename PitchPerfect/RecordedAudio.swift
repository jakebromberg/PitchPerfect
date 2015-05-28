//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/26/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import Foundation

// This is being used as a container to pass data around via performSequeWithIdentifier
// and one of the constraints is that the object must be a reference type.
final public class RecordedAudio: NSObject {
    
    public let title: String!
    public let filePath: NSURL!
    
    init(title: String!, filePath: NSURL!) {
        self.title = title
        self.filePath = filePath
    }
}

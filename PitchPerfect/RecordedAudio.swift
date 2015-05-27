//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/26/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import Foundation

public class RecordedAudio: NSObject {
    
    let title: String!
    let filePath: NSURL!
    
    init(title: String!, filePath: NSURL!) {
        self.title = title
        self.filePath = filePath
    }
}
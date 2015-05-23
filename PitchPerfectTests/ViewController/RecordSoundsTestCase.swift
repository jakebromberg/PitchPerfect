//
//  RecordSoundsTestCase.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/22/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import PitchPerfect
import UIKit
import XCTest

class RecordSoundsTestCase: XCTestCase {
    
    // A few type aliases to save precious time as refactoring tools support in Swift is not there yet
    typealias ViewController = RecordSoundsViewController
    typealias ViewControllerSpy = RecordSoundsViewControllerSpy
    
    func act(testSpy: ViewControllerSpy) {
        executeSpy(testSpy)
    }
    
}
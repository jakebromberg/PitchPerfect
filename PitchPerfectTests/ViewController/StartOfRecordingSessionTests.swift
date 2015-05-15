//
//  StartOfRecordingSessionTests.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/14/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import PitchPerfect
import UIKit
import XCTest

class StartOfRecordingSessionTests: XCTestCase {

    // Validates that 'Record' button is disabled after user taps it.
    func testShouldDisableRecordButton() {
        // Arrange
        var expected = false
        var actual: Bool!
        
        // Act
        self.act() { (c: ViewController) in
            actual = c.recordButton.enabled
        }
        
        // Assert
        XCTAssert(expected == actual, "Fail => expected: '\(expected)' vs. actual: '\(actual)'")
    }
    
    // Validates the 'Stop' button is visible after user taps 'Record' button.
    func testShouldShowStopButton() {
        // Arrange
        var expected = false
        var actual: Bool!
        
        // Act
        self.act() { (c: ViewController) in
            actual = c.stopButton.hidden
        }
        
        // Assert
        XCTAssert(expected == actual, "Fail => expected: '\(expected)' vs. actual: '\(actual)'")
    }
    
    // Validates the label is visible after user taps 'Record' button.
    func testShouldShowRecorderState() {
        // Arrange
        var expected = false
        var actual: Bool!
        
        // Act
        self.act() { (c: ViewController) in
            actual = c.recorderState.hidden
        }
        
        // Assert
        XCTAssert(expected == actual, "Fail => expected: '\(expected)' vs. actual: '\(actual)'")
    }
    
    func act(testSpy: ViewControllerSpy) {
        executeSpy() { (c: ViewController) in
            // Actual scenario work
            tap(c.recordButton)
            
            // Let calling code handle the rest
            testSpy(c)
        }
    }

}
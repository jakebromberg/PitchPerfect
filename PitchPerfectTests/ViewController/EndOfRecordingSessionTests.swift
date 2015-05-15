//
//  ViewControllerTests.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/12/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import PitchPerfect
import UIKit
import XCTest

class EndOfRecordingSessionTests: XCTestCase {
    
    // Validates the 'Stop' button is hidden after user ends a recording session.
    func testEndSessionHidesStopButton() {
        // Arrange
        var expected = true
        var actual: Bool!
        
        // Act
        self.act() { (c: ViewController) in
            actual = c.stopButton.hidden
        }
        
        // Assert
        XCTAssert(expected == actual, "Fail => expected: '\(expected)' vs. actual: '\(actual)'")
    }
    
    // Validates that 'Record' button is enabled after user ends a recording session.
    func testEndSessionEnablesRecordButton() {
        // Arrange
        var expected = true
        var actual: Bool!
        
        // Act
        self.act() { (c: ViewController) in
            actual = c.recordButton.enabled
        }
        
        // Assert
        XCTAssert(expected == actual, "Fail => expected: '\(expected)' vs. actual: '\(actual)'")
    }
    
    // Validates the label is hidden after user ends a recording session.
    func testEndSessionHidesRecorderState() {
        // Arrange
        var expected = true
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
            tap(c.stopButton)
            
            // Let calling code handle the rest
            testSpy(c)
        }
    }

}
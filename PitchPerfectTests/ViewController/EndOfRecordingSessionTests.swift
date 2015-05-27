//
//  ViewControllerTests.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/12/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import PitchPerfect
import Foundation
import UIKit
import XCTest

class EndOfRecordingSessionTests: RecordSoundsTestCase {
    
    func testShouldEnableRecorderHintLabel() {
        // Arrange
        let expected = true
        var actual: Bool!
        
        // Act
        self.act() { (c: ViewController) in
            actual = c.recorderHint.enabled
        }
        
        // Assert
        XCTAssert(expected == actual, "Fail => expected: '\(expected)' vs. actual: '\(actual)'")
    }
    
    // Validates ...
    func testShouldPresentMixmix() {
        // Arrange
        let expected = "Mix-mix"
        
        let expectation = expectationForNotification("prepareForSegue:playSounds", object: nil, handler: { notification in
            let destination = notification.object as! UIViewController
            return expected == destination.title
        })
        
        // Act
        self.act() { (c: ViewController) in
            
        }
        
        // Assert
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    // Validates the 'Stop' button is hidden after user ends a recording session.
    func testShouldHideStopButton() {
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
    func testShouldEnableRecordButton() {
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
    func testShouldHideRecorderState() {
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
    
    override func act(testSpy: ViewControllerSpy) {
        super.act() { (c: ViewController) in
            // Actual scenario work
            tap(c.recordButton)
            tap(c.stopButton)
            
            // Let calling code handle the rest
            testSpy(c)
        }
    }

}

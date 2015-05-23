//
//  GeneralSanityTests.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/14/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import PitchPerfect
import UIKit
import XCTest

class GeneralSanityTests: RecordSoundsTestCase {
    
    // Validates the navigation item of the controller has expected title.
    func testControllerNavigationItemHasExpectedTitle() {
        // Arrange
        let expected = "Record"
        var actual: String?
        
        // Act
        self.act() { (c: ViewController) in
            actual = c.navigationItem.title
        }
        
        // Assert
        XCTAssert(expected == actual, "Fail => expected: '\(expected)' vs. actual: '\(actual)'")
    }
    
    // Validates the view controller has expected title.
    func testControllerHasExpectedTitle() {
        // Arrange
        let expected = "Record"
        var actual: String?
        
        // Act
        self.act() { (c: ViewController) in
            actual = c.title
        }
        
        // Assert
        XCTAssert(expected == actual, "Fail => expected: '\(expected)' vs. actual: '\(actual)'")
    }
    
    // Validates the 'Stop' button outlet is connected to the actual control.
    func testStopButtonOutletIsConnected() {
        // Arrange
        var actual: UIButton?
        
        // Act
        self.act() { (c: ViewController) in
            actual = c.stopButton
        }
        
        // Assert
        XCTAssert(actual != nil, "Assertion failed since stopButton outlet is not connected to the view")
    }
    
    // Validates the 'Record' button outlet is connected to the actual control.
    func testRecordButtonOutletIsConnected() {
        // Arrange
        var actual: UIButton?
        
        // Act
        self.act() { (c: ViewController) in
            actual = c.recordButton
        }
        
        // Assert
        XCTAssert(actual != nil, "Assertion failed since recordButton outlet is not connected to the view")
    }
    
    // Validates the label outlet is connected to the actual control.
    func testRecorderStateOutletIsConnected() {
        // Arrange
        var actual: UILabel?
        
        // Act
        self.act() { (c: ViewController) in
            actual = c.recorderState
        }
        
        // Assert
        XCTAssert(actual != nil, "Assertion failed since recorderState outlet is not connected to the view")
    }
    
}
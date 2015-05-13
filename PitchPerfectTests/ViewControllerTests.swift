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

class ViewControllerTests: XCTestCase {
    
    // Validates the label is hidden after user taps 'Stop' button.
    func testTapStopButtonHidesRecorderState() {
        // Arrange
        var expected = true
        var actual: Bool!
        
        // Act
        self.act() { (c: ViewController) in
            tap(c.stopButton)
            actual = c.recorderState.hidden
        }
        
        // Assert
        XCTAssert(expected == actual, "Fail => expected: '\(expected)' vs. actual: '\(actual)'")
    }
    
    // Validates the label is visible after user taps 'Record' button.
    func testTapRecordButtonShowsRecorderState() {
        // Arrange
        var expected = false
        var actual: Bool!
        
        // Act
        self.act() { (c: ViewController) in
            tap(c.recordButton)
            actual = c.recorderState.hidden
        }
        
        // Assert
        XCTAssert(expected == actual, "Fail => expected: '\(expected)' vs. actual: '\(actual)'")
    }
    
    // Validates the label is hidden by default.
    func testRecorderStateIsHiddenByDefault() {
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
    
    func act(testSpy: ViewControllerSpy) {
        // This snippet has been borrowed from TheMovieDB project [link & credits of the author go here]
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let controller = storyboard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        
        // This snippet has been borrowed from Johan Williams's blog post, see the link: http://bit.ly/1JY63xI
        controller.loadView()
        
        // Let the unit test code analyze the controller's state
        testSpy(controller)
    }

}
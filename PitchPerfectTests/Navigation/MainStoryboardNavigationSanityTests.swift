//
//  GeneralSanityTests.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/15/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import PitchPerfect
import UIKit
import XCTest

// Well, arranging unit tests in Swift is quite an exercise since you cannot "box"
// tests using 'namespace' keyword as in C#. The structure here is flat (or am I missing anything??)
// and you have to be very creative to come up with bunch of names for your tests...

class MainStoryboardNavigationSanityTests: XCTestCase {

    // Validates the default visible view controller's type to ensure Main.storyboard's wiring is accurate
    func testInitialControllerType() {
        // Arrange
        let expected = className(ViewController)
        var actual: NSString!
        
        // Act
        self.act() { (c: UINavigationController) in
            actual = className(c.visibleViewController)
        }
        
        // Assert
        XCTAssert(expected == actual, "Fail => expected: '\(expected)' vs. actual: '\(actual)'")
    }
    
    func act(testSpy: NavigationControllerSpy) {
        executeSpy(testSpy)
    }
}
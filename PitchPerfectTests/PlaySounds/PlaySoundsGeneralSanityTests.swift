//
//  PlaySoundsGeneralSanityTests.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/18/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import PitchPerfect
import UIKit
import XCTest

class PlaySoundsGeneralSanityTests: XCTestCase {
    
    // Validates the 'Chipmunk' button has its currentImage property set.
    func testChipmunkButtonHasNonEmptyImage() {
        // Arrange
        var actual: UIImage?
        
        // Act
        self.act() { (c: PlaySoundsViewController) in
            actual = c.chipmunkButton.currentImage
        }
        
        // Assert
        XCTAssert(actual != nil, "Assertion failed since chipmunkButton has no image set")
    }
    
    // Validates the 'Chipmunk' button outlet is connected to the actual control.
    func testChipmunkButtonOutletIsConnected() {
        // Arrange
        var actual: UIButton?
        
        // Act
        self.act() { (c: PlaySoundsViewController) in
            actual = c.chipmunkButton
        }
        
        // Assert
        XCTAssert(actual != nil, "Assertion failed since chipmunkButton outlet is not connected to the view")
    }
    
    // Validates the 'SlowMo' button has its currentImage property set.
    func testSlowMoButtonHasNonEmptyImage() {
        // Arrange
        var actual: UIImage?
        
        // Act
        self.act() { (c: PlaySoundsViewController) in
            actual = c.slowMoButtom.currentImage
        }
        
        // Assert
        XCTAssert(actual != nil, "Assertion failed since slowMoButton has no image set")
    }
    
    // Validates the 'SlowMo' button outlet is connected to the actual control.
    func testSlowMoButtonOutletIsConnected() {
        // Arrange
        var actual: UIButton?
        
        // Act
        self.act() { (c: PlaySoundsViewController) in
            actual = c.slowMoButtom
        }
        
        // Assert
        XCTAssert(actual != nil, "Assertion failed since slowMoButton outlet is not connected to the view")
    }

    func act(testSpy: PlaySoundsViewControllerSpy) {
        executeSpy(testSpy)
    }

}

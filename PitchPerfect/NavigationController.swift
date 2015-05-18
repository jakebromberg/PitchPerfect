//
//  NavigationController.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/16/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import Foundation
import UIKit


public class NavigationController: UINavigationController {
    
    public override func pushViewController(viewController: UIViewController, animated: Bool) {
        // When executing this code path in the context of the test target, 'animated' argument
        // must be set to false otherwise the controller behavior is not what you expect.
        super.pushViewController(viewController, animated: thisOrThat(animated, false))
    }
}

// TODO: Find more relevant name for this snippet
func thisOrThat<T>(this: T, that: T) -> T {
    // Right now we use environment variable to recognize whether it is the test environment or not
    let environment = NSProcessInfo.processInfo().environment
    if environment["TEST"] != nil {
        return that
    }
    
    return this
}
//
//  extensions.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/12/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import Foundation
import PitchPerfect
import UIKit

// A shorthand to simulate tap on an instance of UIButton control.
func tap(target: UIButton) {
    
    // The snippet has been borrowed from the following SO's thread: http://bit.ly/1PFZyhm
    target.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
}

func touch(controller: UIViewController) {
    let view = controller.view
}

// A shorthand to get class name of the specified view controller as string.
func className(type: UIViewController) -> NSString {
    return className(type.classForCoder)
}

// A shorthand to get class name of the specified type as a string.
func className(type: AnyClass!) -> NSString {
    return NSString(UTF8String: class_getName(type))!
}
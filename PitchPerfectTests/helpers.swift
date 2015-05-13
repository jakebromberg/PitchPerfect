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

// TODO: Find a better place for typealiases used in the tests
typealias ViewControllerSpy = (ViewController) -> Void

// A shorthand to simulate tap on an instance of UIButton control.
func tap(target: UIButton) {
    target.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
}
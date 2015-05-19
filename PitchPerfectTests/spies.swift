//
//  spies.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/16/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import Foundation
import PitchPerfect
import UIKit

typealias ViewControllerSpy = (ViewController) -> Void

typealias NavigationControllerSpy = (NavigationController) -> Void

typealias PlaySoundsViewControllerSpy = (PlaySoundsViewController) -> Void

// TODO: Find a better name for this concept of execution spies.

func executeSpy(testSpy: PlaySoundsViewControllerSpy) {
    // Summon the actual controller from NIB
    let controller: PlaySoundsViewController = executeSpyCore("PlaySoundsController")
    
    // Let the unit test code analyze the controller's state
    testSpy(controller)
}

// A snippet which combines general routine to instantiate and setup UINavigationController.
func executeSpy(testSpy: NavigationControllerSpy) {
    // Summon the actual controller from NIB
    let controller: NavigationController = executeSpyCore("NavigationController")
    
    // Let the unit test code analyze the controller's state
    testSpy(controller)
}

// A snippet which combines general routine to instantiate and setup ViewController.
func executeSpy(testSpy: ViewControllerSpy) {
    // Summon the actual controller from NIB
    let controller: ViewController = executeSpyCore("ViewController")
    
    // Let the unit test code analyze the controller's state
    testSpy(controller)
}

// Core execution spy helper to co-locate commonly used instantiation & setup of a view controller.
// NOTE: Some lightweight patch of generics.
func executeSpyCore<T: UIViewController>(controllerName: String, bundleName: String = "Main") -> T {
    // This snippet has been borrowed from Kevin Mindeguia's TheMovieDB project, see the link: http://bit.ly/1B2PVCG
    let storyboard = UIStoryboard(name: bundleName, bundle: NSBundle.mainBundle())
    let controller = storyboard.instantiateViewControllerWithIdentifier(controllerName) as! T
    
    // This snippet has been borrowed from Johan Williams's blog post, see the link: http://bit.ly/1JY63xI
    controller.loadView()
    
    // Bring back the original controller type
    return controller
}
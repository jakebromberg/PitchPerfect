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
    
    public override func popToRootViewControllerAnimated(animated: Bool) -> [AnyObject]? {
        return super.popToRootViewControllerAnimated(thisOrThat(animated, false))
    }
    
    public override func popViewControllerAnimated(animated: Bool) -> UIViewController? {
        return super.popViewControllerAnimated(thisOrThat(animated, false))
    }
    
    public override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(thisOrThat(animated, false))
    }
    
    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(thisOrThat(animated, false))
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(thisOrThat(animated, false))
    }
    
    public override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(thisOrThat(animated, false))
    }
}

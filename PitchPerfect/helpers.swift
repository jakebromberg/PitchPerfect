//
//  helpers.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/19/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import Foundation
import UIKit

public typealias BundleResourceNotFoundDelegate = () -> Void
public typealias BundleResourceLoadedDelegate = (NSURL!) -> Void
public typealias FetchBundleResourceDelegate = (ok: BundleResourceLoadedDelegate, notfound: BundleResourceNotFoundDelegate)

func fetchResource(name: String, #withExtension: String, #delegate: FetchBundleResourceDelegate) {
    let bundle = NSBundle.mainBundle()
    
    // Just generally it is a good idea to have one if statement in the helper
    // rather than jot it down an every time we fetch a resource from the main bundle
    if let resource = bundle.URLForResource(name, withExtension: withExtension) {
        delegate.ok(resource)
    } else {
        delegate.notfound()
    }
}
//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/18/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import UIKit

public class PlaySoundsViewController: UIViewController {
    
    @IBOutlet public var slowMoButtom: UIButton!
    
    @IBAction func playSlowMo(sender: UIButton, forEvent event: UIEvent) {
        println("in playSlowMo...")
    }
    
}
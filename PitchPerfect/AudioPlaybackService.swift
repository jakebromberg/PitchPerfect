//
//  AudioPlaybackService.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/25/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import Foundation
import AVFoundation

enum AudioEffect {
    case SlowMo, FastMo, Chipmunk, DarthVader
}

class AudioPlaybackService {
    
    private var engine: AVAudioEngine = AVAudioEngine()
    private var file: AVAudioFile!
    private var player: AVAudioPlayerNode!
    private var processor: AVAudioNode!
    
    func prepare(file: NSURL!) {
        self.file = AVAudioFile(forReading: file, error: nil)
        
        // cleanup player node to freed the memory allocated for player node... 
        // It turns out AVAudioPlayerNode allocations are quite expensive, thus 
        // do some cleanup after the previous run & initialize it only when we're about to play the file.
        // This way I've got the memory consumption back under control.
        if self.player != nil {
            // detach the player node first
            self.engine.detachNode(self.player)
            self.player = nil
        }
        
        // init & attach the player
        self.player = AVAudioPlayerNode()
        self.engine.attachNode(self.player)
    }
    
    func play(effect: AudioEffect) {
        // ensure we always stop the playback that is already in the queue
        self.stop()
        
        // cleanup the previous processor to freed the memory
        if self.processor != nil {
            self.engine.detachNode(self.processor)
            self.processor = nil
        }
        
        // init & attach a new processor
        self.processor = self.processing(effect)
        self.engine.attachNode(self.processor)
        
        self.engine.connect(self.player, to: self.processor, format: self.file.processingFormat)
        self.engine.connect(self.processor, to: self.engine.mainMixerNode, format: self.file.processingFormat)
        
        // player should be initialized & ready by this time,
        // so we're good to schedule play the file as soon as possible (atTime: nil)
        self.player.scheduleFile(self.file!, atTime: nil, completionHandler: nil)

        // start the audio engine if it isn't running yet
        if self.engine.running == false {
            var error: NSError?
            if self.engine.startAndReturnError(&error) == false {
                println(error)
                return
            }
        }
        
        // poke the player to activate the chain
        self.player.play()
    }
    
    func stop() {
        // call to stop player, not the engine
        self.player.stop()
    }
    
    private func processing(effect: AudioEffect) -> AVAudioNode? {
        var node: AVAudioNode?
        
        switch effect {
        case .FastMo:
            let unode = AVAudioUnitTimePitch()
            unode.rate = 2
            node = unode
        case .SlowMo:
            let unode = AVAudioUnitTimePitch()
            unode.rate = 0.6
            node = unode
        case .Chipmunk:
            let unode = AVAudioUnitTimePitch()
            unode.pitch = 1200
            node = unode
        default:
            abort()
        }
        
        return node
    }
}
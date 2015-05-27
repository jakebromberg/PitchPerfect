//
//  AudioPlaybackService.swift
//  PitchPerfect
//
//  Created by Pavel Tsurbeleu on 5/25/15.
//  Copyright (c) 2015 Pavel Tsurbeleu. All rights reserved.
//

import Foundation
import AVFoundation

class AudioPlaybackService: NSObject {
    
    private let engine: AVAudioEngine = AVAudioEngine()
    private var file: AVAudioFile!
    private var player: AVAudioPlayerNode!
    private var processor: AVAudioNode!
    
    func prepare(file: NSURL!) {
        self.file = AVAudioFile(forReading: file, error: nil)
        
        // cleanup player node to freed the memory allocated for player node... 
        // It turns out AVAudioPlayerNode allocations are quite expensive, thus 
        // do some cleanup after the previous run & initialize it only when we're about to play the file.
        // This way I've got the memory consumption back under control.
        if player != nil {
            // detach the player node first
            engine.detachNode(player)
            player = nil
        }
        
        // init & attach the player
        player = AVAudioPlayerNode()
        engine.attachNode(player)
    }
    
    func play(effect: AudioEffect) {
        // ensure we always stop the playback that is already in the queue
        stop()
        
        // cleanup the previous processor to freed the memory
        if processor != nil {
            engine.detachNode(processor)
            processor = nil
        }
        
        // init & attach a new processor
        processor = processing(effect)
        engine.attachNode(processor)
        
        let fileFormat = file.processingFormat
        engine.connect(player, to: processor, format: fileFormat)
        engine.connect(processor, to: engine.mainMixerNode, format: fileFormat)
        
        // player should be initialized & ready by this time,
        // so we're good to schedule play the file as soon as possible (atTime: nil)
        player.scheduleFile(file!, atTime: nil, completionHandler: nil)

        // start the audio engine if it isn't running yet
        if engine.running == false {
            var error: NSError?
            if engine.startAndReturnError(&error) == false {
                println(error)
                return
            }
        }
        
        // poke the player to activate the chain
        player.play()
    }
    
    func stop() {
        // call to stop player, not the engine
        player.stop()
    }
    
    private func processing(effect: AudioEffect) -> AVAudioNode? {
        var node: AVAudioNode?
        
        switch effect {
        case .DarthVader:
            let unode = AVAudioUnitTimePitch()
            unode.rate = 0.80
            unode.pitch = -800
            node = unode
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

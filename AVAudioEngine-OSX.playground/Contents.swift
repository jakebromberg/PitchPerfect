//: Playground - noun: a place where people can play

import Cocoa
import AVFoundation
import XCPlayground

//: (0) Init the audio file first
var bundle = NSBundle.mainBundle()
var urlOfMovieQuote = bundle.URLForResource("movie_quote", withExtension: "mp3")

enum AudioEffect {
    case SlowMo, FastMo, Chipmunk, DarthVader
}

class AudioPlaybackService {
    
    private var engine: AVAudioEngine = AVAudioEngine()
    private var file: AVAudioFile!
    
    func prepare(file: NSURL!) {
        self.file = AVAudioFile(forReading: file, error: nil)
    }
    
    func play(effect: AudioEffect) {
        var mainMixer = self.engine.mainMixerNode
        
        var player = AVAudioPlayerNode()
        let processor = self.processing(effect)
        
        engine.attachNode(player)
        engine.attachNode(processor)
        
        engine.connect(player, to: processor, format: file.processingFormat)
        engine.connect(processor, to: mainMixer, format: file.processingFormat)
        
        // (5) schedule to play the file as soon as possible (atTime: nil)
        player.scheduleFile(self.file, atTime: nil, completionHandler: nil)
        
        //: (6) start the audio engine
        var error: NSError?
        if engine.startAndReturnError(&error) {
            //: (7) poke the player to activate the chain
            player.play()
        } else {
            println(error)
        }
    }
    
    func stop() {
        engine.stop()
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
            unode.rate = 1.5
            node = unode
        default:
            node = nil
        }
        
        return node
    }
}

let audioService = AudioPlaybackService()
audioService.prepare(urlOfMovieQuote)
audioService.play(AudioEffect.DarthVader)

//: Secret ingredient - run the playground indefinitely to keep background threads alive (those created by AVAudioEngine)
//: Credits to Jamie Bullock's post: [Live coding audio with Swift Playgrounds](http://jamiebullock.com/post/89243252529/live-coding-audio-with-swift-playgrounds)
XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)

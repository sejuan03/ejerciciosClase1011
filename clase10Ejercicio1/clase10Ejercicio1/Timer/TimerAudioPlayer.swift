//
//  TimerAudioPlayer.swift
//  clase10Ejercicio1
//
//  Created by Mac on 30/12/22.
//

import AVFoundation
import AudioToolbox

class TimerAudioPlayer {
    
    private var player: AVAudioPlayer?
    
    func playSound() {
        let soundURLOptional =  Bundle.main.url(forResource: "clearday", withExtension: "mp3")
        guard let soundURL = soundURLOptional else {
            return
        }
        do {
            try player = AVAudioPlayer(contentsOf: soundURL)
        } catch {
            return
        }
        player?.play()
    }

}

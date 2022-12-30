//
//  TimerManager.swift
//  clase10Ejercicio1
//
//  Created by Mac on 20/12/22.
//

import AVFoundation
import AudioToolbox

protocol TimerManagerDelegate : AnyObject {
    func processTimerTick()
}

class TimerManager {
    
    private weak var delegate: TimerManagerDelegate?
    private var timer: Timer?
    private var player: AVAudioPlayer?
    
    func setDelegate(_ delegate: TimerManagerDelegate) {
        self.delegate = delegate
    }
    
    func starTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(processTick),
            userInfo: nil,
            repeats: true)
    }
    
    @objc private func processTick() {
        guard let delegate = delegate else {
            return
        }
        delegate.processTimerTick()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
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
    
    func startVibration() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}

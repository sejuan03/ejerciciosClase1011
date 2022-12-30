//
//  QuestionaryTimerManager.swift
//  Clase10Ejercicio2
//
//  Created by Mac on 21/12/22.
//
import UIKit

protocol QuestionaryTimerManagerDelegate : AnyObject {
    func processSoundTick()
}

class QuestionaryTimerManager {
    private weak var delegate: QuestionaryTimerManagerDelegate?
    private var timer: Timer?
    
    func setDelegate(_ delegate: QuestionaryTimerManagerDelegate) {
        self.delegate = delegate
    }
    
    func startSoundTimer() {
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
        delegate.processSoundTick()
    }
    
    func stopSoundTimer() {
        timer?.invalidate()
        timer = nil
    }
}


//
//  TimerManager.swift
//  clase10Ejercicio1
//
//  Created by Mac on 20/12/22.
//

import UIKit

protocol TimerManagerDelegate : AnyObject {
    func processTimerTick()
}

class TimerManager {
    
    private weak var delegate: TimerManagerDelegate?
    private var timer: Timer?
   
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
}

//
//  GameTimerManager.swift
//  Clase10Ejercicio3
//
//  Created by Mac on 20/12/22.
//

import Foundation

protocol GameTimerManagerDelegate : AnyObject {
    func processInitialTimerTick()
    func processVisibilityTimerTick()
}

class GameTimerManager {
    
    private struct Constant {
        static let initialInterval = 1.0
    }
    
    private weak var delegate: GameTimerManagerDelegate?
    private var timer: Timer?
    
    func setDelegate(_ delegate: GameTimerManagerDelegate) {
        self.delegate = delegate
    }
    
    func startTimer(_ timeInterval: Double) {
        var selector: Selector!
        if timeInterval == Constant.initialInterval {
            selector = #selector(processInitialTick)
        } else {
            selector = #selector(processVisibilityTimerTick)
        }
        timer = Timer.scheduledTimer(
            timeInterval: timeInterval,
            target: self,
            selector: selector,
            userInfo: nil,
            repeats: true)
    }
    
    @objc private func processInitialTick() {
        guard let delegate = delegate else {
            return
        }
        delegate.processInitialTimerTick()
    }
    
    @objc private func processVisibilityTimerTick() {
        guard let delegate = delegate else {
            return
        }
        delegate.processVisibilityTimerTick()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}


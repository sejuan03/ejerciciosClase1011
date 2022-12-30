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
    private weak var delegate: GameTimerManagerDelegate?
    private var initialTimer: Timer?
    private var visibilityTimer : Timer?
    
    func setDelegate(_ delegate: GameTimerManagerDelegate) {
        self.delegate = delegate
    }
    
    func startInitialTimer() {
        initialTimer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(processInitialTick),
            userInfo: nil,
            repeats: true)
    }
    
    @objc private func processInitialTick() {
        guard let delegate = delegate else {
            return
        }
        delegate.processInitialTimerTick()
    }
    
    func stopInitialTimer() {
        initialTimer?.invalidate()
        initialTimer = nil
    }
    
    func startVisibilityTimer() {
        visibilityTimer = Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(processVisibilityTimerTick),
            userInfo: nil,
            repeats: true)
    }
    
    @objc private func processVisibilityTimerTick() {
        guard let delegate = delegate else {
            return
        }
        delegate.processVisibilityTimerTick()
    }
    
    func stopVisibilityTimer() {
        visibilityTimer?.invalidate()
        visibilityTimer = nil
    }
}


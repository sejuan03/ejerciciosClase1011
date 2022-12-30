//
//  TimerBrain.swift
//  clase10Ejercicio1
//
//  Created by Mac on 20/12/22.
//
import Foundation

protocol TimerBrainProtocol : AnyObject {
    func setViewController (_ viewController: TimerViewControllerProtocol)
    func setTimeout(_ time: Int)
    func processViewDidLoad()
}

class TimerBrain {
    
    private weak var viewController : TimerViewControllerProtocol?
    private var timeOut: Int?
    private var currentTime = 0
    private var timeRemainingCalculator = TimeRemainingCalculator()
    private var timeRemainingPresenter = TimeRemainingPresenter()
    private var timeProgressCalculator = TimeProgressCalculator()
    private var timerManager = TimerManager()
    
    private func updateUI() {
        updateRemainingTime()
        updateProgress()
    }
    
    private func updateRemainingTime() {
        guard let timeOut = timeOut else {
            return
        }
        guard let viewController = viewController else {
            return
        }
        let timeRemaining = timeRemainingCalculator.getTimeRemaining(timeOut, currentTime)
        let timeRemainingString = timeRemainingPresenter.convertToText(timeRemaining: timeRemaining)
        viewController.setTimeRemaining(timeRemainingString)
    }
    
    func updateProgress() {
        guard let timeOut = timeOut else {
            return
        }
        guard let viewController = viewController else {
            return
        }
        let progress = timeProgressCalculator.getProgress(timeOut, currentTime)
        viewController.setProgressView(progress)
    }
    
    func startTimer() {
        timerManager.setDelegate(self)
        timerManager.starTimer()
    }
}

extension TimerBrain : TimerBrainProtocol {
    func setViewController (_ viewController: TimerViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func setTimeout(_ time: Int) {
        timeOut = time
    }
    
    func processViewDidLoad() {
        updateUI()
        startTimer()
    }
}

extension TimerBrain : TimerManagerDelegate {
    func processTimerTick() {
        guard let timeOut = timeOut else {
            return
        }
        currentTime += 1
        updateUI()
        if currentTime >= timeOut {
            timerManager.stopTimer()
            timerManager.playSound()
            timerManager.startVibration()
        }
    }
}

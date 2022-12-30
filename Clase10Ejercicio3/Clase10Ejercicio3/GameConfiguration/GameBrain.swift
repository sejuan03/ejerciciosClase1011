//
//  GameBrain.swift
//  Clase10Ejercicio3
//
//  Created by Mac on 20/12/22.
//

import Foundation

protocol GameBrainProtocol : AnyObject {
    func setViewController(_ viewController: GameViewControllerProtocol)
    func processWin()
    func startGame()
}

class GameBrain {
    
    private struct Constant {
        static let initialTimer = 1.0
        static let visibilityTimer = 0.1
        static let visibilityTimeout = 2
        static let hidden = true
    }
    
    private weak var viewController: GameViewControllerProtocol?
    private var timerManager = GameTimerManager()
    private var winningScore = 0
    private var winningScoreMessage = ""
    private var losingScoreMessage = ""
    private var losingScore = 0
    private var totalGames = 0
    private var totalGamesPlayed = ""
    private var randomTimeout = 0
    private var currentTime = 0
    private var timeoutReached = false
    
    private func processWinningScore() {
        updateWinningScore()
        setWinningScoreMessage()
    }
    
    private func updateWinningScore() {
        winningScore += 1
    }
    
    private func setWinningScoreMessage() {
        winningScoreMessage = "\(winningScore)"
    }
    
    private func processLosingScore() {
        updateLosingScore()
        setLosingScoreMessage()
    }
    
    private func updateLosingScore() {
        losingScore += 1
    }
    
    private func setLosingScoreMessage() {
        losingScoreMessage = "\(losingScore)"
    }
    
    private func processTotalGamesPlayed() {
        updateTotalGamesPlayed()
        setTotalGamesPlayedText()
    }
    
    private func updateTotalGamesPlayed() {
        totalGames = winningScore + losingScore
    }
    
    private func setTotalGamesPlayedText() {
        totalGamesPlayed = "\(totalGames)"
    }
    
    private func updateRandomTimeout() {
        randomTimeout = Int.random(in: 3...10)
    }
    
    private func startInitialTimer() {
        timerManager.setDelegate(self)
        timerManager.startTimer(Constant.initialTimer)
    }
    
    private func updateCurrentTime() {
        currentTime += 1
    }
    
    private func validateCurrentTime(_ timeout: Int) {
        timeoutReached = currentTime == timeout
    }
    
    private func processInitialTimeout() {
        if timeoutReached {
            stopTimer()
            resetCurrentTime()
            updateVisibility(!Constant.hidden)
            timerManager.startTimer(Constant.visibilityTimer)
        }
    }
    
    private func stopTimer() {
        timerManager.stopTimer()
    }
    
    private func resetCurrentTime() {
        currentTime = 0
        timeoutReached = false
    }
    
    private func updateVisibility(_ visibility: Bool) {
        guard let viewController = viewController else {
            return
        }
        viewController.updateGameButtonVisibility(with: visibility)
    }
    
    private func processVisibilityTimeout() {
        if timeoutReached {
            stopTimer()
            resetCurrentTime()
            processLosingScore()
            processTotalGamesPlayed()
            updateUI()
        }
    }
    
    private func updateUI() {
        updateVisibility(Constant.hidden)
        guard let viewController = viewController else {
            return
        }
        viewController.showLosingAlert()
        viewController.setLosingScore(with: losingScoreMessage)
        viewController.setTotalGames(with: totalGamesPlayed)
    }
}

extension GameBrain : GameBrainProtocol {
    func setViewController(_ viewController: GameViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func processWin() {
        guard let viewController = viewController else {
            return
        }
        timerManager.stopTimer()
        currentTime = 0
        processWinningScore()
        processTotalGamesPlayed()
        viewController.updateGameButtonVisibility(with: true)
        viewController.showWinningAlert()
        viewController.setWinningScore(with: winningScoreMessage)
        viewController.setTotalGames(with: totalGamesPlayed)
    }
    
    func startGame() {
        updateRandomTimeout()
        startInitialTimer()
    }
}

extension GameBrain : GameTimerManagerDelegate {
    func processInitialTimerTick() {
        updateCurrentTime()
        validateCurrentTime(randomTimeout)
        processInitialTimeout()
    }
    
    func processVisibilityTimerTick() {
        updateCurrentTime()
        validateCurrentTime(Constant.visibilityTimeout)
        processVisibilityTimeout()
    }
}

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
        timerManager.startInitialTimer()
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
        timerManager.stopVisibilityTimer()
        currentTime = 0
        processWinningScore()
        processTotalGamesPlayed()
        viewController.updateUIVisibility(with: true)
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
        currentTime += 1
        if currentTime == randomTimeout {
            guard let viewController = viewController else {
                return
            }
            timerManager.stopInitialTimer()
            currentTime = 0
            viewController.updateUIVisibility(with: false)
            timerManager.startVisibilityTimer()
        }
    }
    
    func processVisibilityTimerTick() {
        currentTime += 1
        if currentTime > 2 {
            guard let viewController = viewController else {
                return
            }
            timerManager.stopVisibilityTimer()
            currentTime = 0
            processLosingScore()
            processTotalGamesPlayed()
            viewController.updateUIVisibility(with: true)
            viewController.showLosingAlert()
            viewController.setLosingScore(with: losingScoreMessage)
            viewController.setTotalGames(with: totalGamesPlayed)
        }
    }
}

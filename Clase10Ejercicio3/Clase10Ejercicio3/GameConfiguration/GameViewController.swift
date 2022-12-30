//
//  ViewController.swift
//  Clase10Ejercicio3
//
//  Created by Mac on 20/12/22.
//

import UIKit

protocol GameViewControllerProtocol : AnyObject {
    func showWinningAlert()
    func showLosingAlert()
    func setWinningScore(with winningScore: String)
    func setLosingScore(with losingScore: String)
    func setTotalGames(with totalGames: String)
    func updateUIVisibility(with visibility: Bool)
}

class GameViewController: UIViewController{
    
    private struct Constant {
        static let winningAlertTitle = "GANASTE"
        static let losingAlertTitle = "Upsss"
        static let winningAlertMessage = "Felicitaciones"
        static let losingAlertMessage = "Intenta de Nuevo"
        static let ok = "Excelente"
        static let cancel = "OK"
    }
    
    @IBOutlet weak var totalGamesLabel: UILabel!
    @IBOutlet weak var winningScoreLabel: UILabel!
    @IBOutlet weak var losingScoreLabel: UILabel!
    @IBOutlet weak var gameButton: UIButton!
    
    private var brain: GameBrainProtocol = GameBrain()
    private var winningAlert: UIAlertController!
    private var losingAlert: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAlerts()
        brain.setViewController(self)
        brain.startGame()
    }
    
    private func createAlerts() {
        winningAlert = UIAlertController(title: Constant.winningAlertTitle, message: Constant.winningAlertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constant.ok, style: .default) { action in
            self.restartGameHandler()
        }
        winningAlert.addAction(okAction)
        
        losingAlert = UIAlertController(title: Constant.losingAlertTitle, message: Constant.losingAlertMessage, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: Constant.cancel, style: .default) { action in
            self.restartGameHandler()
        }
        losingAlert.addAction(cancelAction)
    }
    
    private func restartGameHandler() {
        brain.startGame()
    }
    
    @IBAction func onGameButtonPressed(_ sender: Any) {
        brain.processWin()
    }
}

extension GameViewController : GameViewControllerProtocol {
    func showWinningAlert() {
        present(winningAlert, animated: true)
    }
    
    func showLosingAlert() {
        present(losingAlert, animated: true)
    }
    
    func setWinningScore(with winningScore: String) {
        winningScoreLabel.text = winningScore
    }
    
    func setLosingScore(with losingScore: String) {
        losingScoreLabel.text = losingScore
    }
    
    func setTotalGames(with totalGames: String) {
        totalGamesLabel.text = totalGames
    }
    
    func updateUIVisibility(with visibility: Bool) {
        gameButton.isHidden = visibility
    }
}


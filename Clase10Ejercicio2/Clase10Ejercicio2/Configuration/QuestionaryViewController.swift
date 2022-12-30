//
//  ViewController.swift
//  Clase10Ejercicio2
//
//  Created by Mac on 19/12/22.
//

import UIKit
import AVFoundation
import AudioToolbox

protocol QuestionaryViewControllerProtocol : AnyObject {
    func updateQuestionLabel(with question: String)
    func updateProgressView(with progress: Float)
    func presentAlert(with testResultMessage: String)
}


class QuestionaryViewController: UIViewController {
    
    private struct Constant {
        static let resultTitle = "Resultado"
        static let ok = "OK"
        static let affirmative = "SI"
        static let negative = "NO"
    }
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionsProgressView: UIProgressView!
    
    private var brain: QuestionaryBrainProtocol = QuestionaryBrain()
    
    private var alertResult: UIAlertController!
    private var testResultMessage = ""
    private var answer = ""
    
    private var song = ""
    private var timer: Timer?
    private var currentTime = 0
    private var player: AVAudioPlayer?
    
    private var isAnswerCorrect = false
    private var testFinished = false
    private var countCorrectAnswers = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brain.setViewController(self)
        brain.updateUI()
        createResultAlert()
    }
    
    private func createResultAlert() {
        alertResult = UIAlertController(title: Constant.resultTitle, message: testResultMessage, preferredStyle: .alert)
        let okResultAction = UIAlertAction(title: Constant.ok, style: .default)
        alertResult.addAction(okResultAction)
    }
    
    @IBAction func onAffirmativeAnswerButtonPressed(_ sender: Any) {
        brain.processAnswer(with: Constant.affirmative)
    }
    
    @IBAction func onNegativeAnswerButtonPressed(_ sender: Any) {
        brain.processAnswer(with: Constant.negative)
    }
}

extension QuestionaryViewController: QuestionaryViewControllerProtocol {
    func updateQuestionLabel(with question: String) {
        questionLabel.text = question
    }
    
    func updateProgressView(with progress: Float) {
        questionsProgressView.progress = progress
    }
    
    func presentAlert(with testResultMessage: String) {
        alertResult.message = testResultMessage
        present(alertResult, animated: true)
    }
}

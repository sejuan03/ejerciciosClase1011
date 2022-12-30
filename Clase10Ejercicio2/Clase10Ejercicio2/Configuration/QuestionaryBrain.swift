//
//  QuestionaryBrain.swift
//  Clase10Ejercicio2
//
//  Created by Mac on 21/12/22.
//

import AVFoundation
import AudioToolbox

protocol QuestionaryBrainProtocol : AnyObject {
    func setViewController(_ viewController: QuestionaryViewControllerProtocol)
    func updateUI()
    func processAnswer(with answer: String)
}

class QuestionaryBrain {
    private struct Constant {
        static let rigthAnswerMessage = "respuestas correctas"
        static let rightAnswer = "correcto"
        static let badAnswer = "incorrecto"
        static let songExtension = "mp3"
    }
    
    private var viewController: QuestionaryViewControllerProtocol?
    private var questionary: QuestionaryAnswerProtocol = QuestionaryAnswer()
    private var questionaryTimerManager = QuestionaryTimerManager()
    
    private var question = ""
    private var questionaryIndex = 0
    private var progress: Float = 0.0
    private var answer = ""
    
    private var song = ""
    private var timer: Timer?
    private var currentTime = 0
    private var player: AVAudioPlayer?
    
    private var isAnswerCorrect = false
    private var testFinished = false
    private var countCorrectAnswers = 0
    private var testResultMessage = ""
    
    
    private func updateQuestion() {
        question = Questionary.questions[questionaryIndex].questionLabel
    }
    
    private func updateProgress() {
        progress = Float(questionaryIndex) / Float(Questionary.questions.count-1)
    }
    
    private func verifyAnswer() {
        isAnswerCorrect = questionary.verifyCorrectAnswer(Questionary.questions[questionaryIndex].questionLabel, answer)
    }
    
    private func validateAnswer() {
        if isAnswerCorrect {
            countCorrectAnswers += 1
            song = Constant.rightAnswer
        } else {
            song = Constant.badAnswer
        }
        startVibrationAndSound()
    }
    
    private func startVibrationAndSound() {
        startVibration()
        startSound()
        startSoundTimer()
    }
    
    private func startVibration() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    private func startSound() {
        let soundURLOptional =  Bundle.main.url(forResource: song, withExtension: Constant.songExtension)
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
    
    private func startSoundTimer() {
        questionaryTimerManager.setDelegate(self)
        questionaryTimerManager.startSoundTimer()
    }
    
    private func updateQuestionaryIndex() {
        questionaryIndex += 1
    }
    
    private func validateQuestionaryFinished() {
        if questionaryIndex == Questionary.questions.count {
            guard let viewController = viewController else {
                return
            }
            setupResultMessageAlert()
            viewController.presentAlert(with: testResultMessage)
            questionaryIndex = 0
            countCorrectAnswers = 0
            updateUI()
        }
        updateUI()
    }
    
    private func setupResultMessageAlert() {
        testResultMessage = "\(countCorrectAnswers) \(Constant.rigthAnswerMessage)"
    }
}

extension QuestionaryBrain: QuestionaryBrainProtocol {
    func setViewController(_ viewController: QuestionaryViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func updateUI() {
        guard let viewController = viewController else {return}
        updateQuestion()
        updateProgress()
        viewController.updateQuestionLabel(with: question)
        viewController.updateProgressView(with: progress)
    }
    
    func processAnswer(with answer: String) {
        self.answer = answer
        verifyAnswer()
        validateAnswer()
        updateQuestionaryIndex()
        validateQuestionaryFinished()
    }
}

extension QuestionaryBrain: QuestionaryTimerManagerDelegate {
    func processSoundTick() {
        currentTime += 1
        if currentTime == 2 {
            currentTime = 0
            questionaryTimerManager.stopSoundTimer()
            player?.stop()
        }
    }
}

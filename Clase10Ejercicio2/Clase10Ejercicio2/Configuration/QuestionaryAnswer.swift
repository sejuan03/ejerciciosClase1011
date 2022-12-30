//
//  QuestionaryRepositoryImpl.swift
//  Clase10Ejercicio2
//
//  Created by Mac on 19/12/22.
//
protocol QuestionaryAnswerProtocol {
    func verifyCorrectAnswer (_ question: String, _ answer: String) -> Bool
}

class QuestionaryAnswer : QuestionaryAnswerProtocol {
    func verifyCorrectAnswer (_ question: String, _ answer: String) -> Bool {
        return Questionary.questions.contains { q in
            q.questionLabel == question && q.correctAnswer == answer
        }
    }
}

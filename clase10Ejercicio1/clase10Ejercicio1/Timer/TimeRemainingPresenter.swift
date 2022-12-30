//
//  TimeRemainingPresenter.swift
//  clase10Ejercicio1
//
//  Created by Mac on 20/12/22.
//

class TimeRemainingPresenter {
    func convertToText(timeRemaining: TimeRemaining) -> String {
        let minutesAsString = "\(timeRemaining.minutes)"
        let secondsAsString = "\(timeRemaining.seconds < 10 ? "0" : "")\(timeRemaining.seconds)"
        return "\(minutesAsString):\(secondsAsString)"
    }
}

//
//  TimeRemainingCalculator.swift
//  clase10Ejercicio1
//
//  Created by Mac on 20/12/22.
//

struct TimeRemaining {
    let seconds: Int
    let minutes: Int
}

class TimeRemainingCalculator {
    func getTimeRemaining(_ timeOut: Int, _ currentTime: Int) -> TimeRemaining {
        let secondsLeft = Float(timeOut - currentTime)
        let minutes = Int(secondsLeft / 60.0)
        let seconds = Int(secondsLeft) % 60
        
        return TimeRemaining(seconds: seconds,minutes: minutes)
    }
}

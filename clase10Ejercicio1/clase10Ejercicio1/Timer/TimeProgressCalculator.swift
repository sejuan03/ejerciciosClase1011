//
//  TimeProgressCalculator.swift
//  clase10Ejercicio1
//
//  Created by Mac on 20/12/22.
//

class TimeProgressCalculator {
    func getProgress(_ timeOut: Int, _ currentTime: Int) -> Float {
        Float(currentTime) / Float(timeOut)
    }
}

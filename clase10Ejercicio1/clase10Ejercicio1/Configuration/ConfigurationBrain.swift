//
//  ConfigurationBrain.swift
//  clase10Ejercicio1
//
//  Created by Mac on 20/12/22.
//

import Foundation

protocol ConfigurationBrainProtocol : AnyObject {
    func setViewController(_ viewController : ConfigurationViewControllerProtocol)
    func processContinueButtonPressed(with timeOutText: String)
    func getTimeOut() -> Int
}

class ConfigurationBrain {
    private struct Constant {
        static let errorMessage = "Error"
    }
    private weak var viewController: ConfigurationViewControllerProtocol?
    private var timeOut = 0
}

extension ConfigurationBrain: ConfigurationBrainProtocol {
    
    func setViewController(_ viewController: ConfigurationViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func processContinueButtonPressed(with timeOutText: String) {
        guard let viewController = viewController else {
            return
        }
        if let timeOut = Int(timeOutText) {
            self.timeOut = timeOut
            viewController.navigateTowardsTimer()
        } else {
            viewController.presentErrorAlert(with: Constant.errorMessage)
        }
    }
    
    func getTimeOut() -> Int {
        timeOut
    }
}



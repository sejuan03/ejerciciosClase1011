//
//  ViewController.swift
//  clase10Ejercicio1
//
//  Created by Mac on 13/12/22.
//

import UIKit

protocol ConfigurationViewControllerProtocol : AnyObject {
    func navigateTowardsTimer()
    func presentErrorAlert(with message: String)
}

class ConfigurationViewController: UIViewController {
    
    private struct Constant {
        static let segueToTimer = "goToTimerView"
    }

    @IBOutlet weak var secondsTimeoutTextField: UITextField!
    
    private let brain : ConfigurationBrainProtocol = ConfigurationBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brain.setViewController(self)
    }
    
    @IBAction func onContinueButtonPressed() {
        guard let timeoutText = secondsTimeoutTextField.text else {
            return
        }
        brain.processContinueButtonPressed(with: timeoutText)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let timerViewController = segue.destination as? TimerViewController else {
            return
        }
        let secondsTimeout = brain.getTimeOut()
        timerViewController.setTimeout(secondsTimeout)
    }
}

extension ConfigurationViewController : ConfigurationViewControllerProtocol {
    func navigateTowardsTimer() {
        performSegue(withIdentifier: Constant.segueToTimer, sender: self)
    }
    
    func presentErrorAlert(with message : String) {
        let errorAlert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let alertOKAction = UIAlertAction(title: "OK", style: .default)
        errorAlert.addAction(alertOKAction)
        present(errorAlert, animated: true)
    }
}

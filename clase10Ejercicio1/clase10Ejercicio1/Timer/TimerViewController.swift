//
//  TimerViewController.swift
//  clase10Ejercicio1
//
//  Created by Mac on 13/12/22.
//

import UIKit
import AVFoundation
import AudioToolbox

protocol TimerViewControllerProtocol : AnyObject {
    func setTimeRemaining(_ timeRemainingText: String)
    func setProgressView(_ progress: Float)
}

class TimerViewController: UIViewController {
    
    
    @IBOutlet weak var timeoutLabel: UILabel!
    @IBOutlet weak var timeOutProgressView: UIProgressView!
    
    private let timerBrain: TimerBrainProtocol = TimerBrain()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerBrain.setViewController(self)
        timerBrain.processViewDidLoad()
        
    }
    
    func setTimeout(_ timeout: Int) {
        timerBrain.setTimeout(timeout)
    }
}

extension TimerViewController : TimerViewControllerProtocol {
    func setTimeRemaining(_ timeRemainingText: String) {
        timeoutLabel.text = timeRemainingText
    }
        
    func setProgressView(_ progress: Float) {
        timeOutProgressView.progress = progress
    }
}

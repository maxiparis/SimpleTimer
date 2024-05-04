//
//  TimerStartViewController.swift
//  SimpleTimer
//
//  Created by Maximiliano París Gaete on 5/3/24.
//

import UIKit
import SRCountdownTimer

class TimerStartViewController: UIViewController, SRCountdownTimerDelegate {
    //MARK: - Class Variables
    
    var hour = 0
    var minute = 0
    var totalTime = 0
    var name = ""
    
    var circleTimer: SRCountdownTimer = {
        var timer = SRCountdownTimer()
        timer.labelFont = UIFont.systemFont(ofSize: 30)
        timer.labelTextColor = UIColor.white
        timer.timerFinishingText = "Done"
        timer.useMinutesAndSecondsRepresentation = true
        timer.backgroundColor = UIColor.clear
        timer.lineColor = UIColor(named: "blueApp")!
        timer.lineWidth = 5
        return timer
    }()

    @IBOutlet weak var timerName: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    //MARK: - Views Loaded and Appeared

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        insertTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        totalTime = (hour*60) + (minute)
        circleTimer.start(beginingValue: totalTime)
    }
    
    func updateUI(){
        timerName.text = name
        pauseButton.tintColor = UIColor(named: "greenApp")
        stopButton.tintColor = UIColor(named: "redApp")
    }
    
    //MARK: - Timer Configurations
    
    func insertTimer(){
        view.addSubview(circleTimer)
        circleTimer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circleTimer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circleTimer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circleTimer.widthAnchor.constraint(equalToConstant: 300),
            circleTimer.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

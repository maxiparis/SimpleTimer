//
//  TimerStartViewController.swift
//  SimpleTimer
//
//  Created by Maximiliano París Gaete on 5/3/24.
//

import UIKit
import SRCountdownTimer

class TimerStartViewController: UIViewController, SRCountdownTimerDelegate {
    var hour = 0
    var minute = 0
    var name = ""
    var circleTimer = SRCountdownTimer()

    @IBOutlet weak var timerName: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = "\(hour):\(minute)"
        timerName.text = name
        pauseButton.tintColor = UIColor(named: "greenApp")
        stopButton.tintColor = UIColor(named: "redApp")
        insertTimer()
        circleTimer.start(beginingValue: 50)
    }
    
    func insertTimer(){
        view.addSubview(circleTimer)
        circleTimer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                    // Example constraints: center the view horizontally and vertically, and set width and height
            circleTimer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circleTimer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circleTimer.widthAnchor.constraint(equalToConstant: 300),
            circleTimer.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

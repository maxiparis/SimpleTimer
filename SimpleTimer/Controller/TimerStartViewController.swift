//
//  TimerStartViewController.swift
//  SimpleTimer
//
//  Created by Maximiliano París Gaete on 5/3/24.
//

import UIKit

class TimerStartViewController: UIViewController {
    var hour = 0
    var minute = 0
    var name = ""

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
    }
}

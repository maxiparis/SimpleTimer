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
    
    var data: Data = Data()
    
    var circleTimer: SRCountdownTimer = {
        var timer = SRCountdownTimer()
//        timer.labelFont = UIFont(name: "CourierNewPSMT", size: 30.0) // monospace
        timer.labelFont = UIFont.systemFont(ofSize: 30.0)
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
        circleTimer.start(beginingValue: data.totalTimeInSeconds ?? 0)
    }
    
    func updateUI(){
        timerName.text = data.name
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
        
        // Set constraints for the UILabel
        NSLayoutConstraint.activate([
            timerName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerName.bottomAnchor.constraint(equalTo: circleTimer.topAnchor, constant: -10) // Adjust the constant as needed
        ])
    }
    
    //MARK: - Buttons Pressed

    @IBAction func stopPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func pausePressed(_ sender: UIButton) {
        if (data.paused) {
            // resume
            circleTimer.resume()
            pauseButton.setTitle("Pause", for: .normal)
            data.paused = false
        } else { //is not paused
            //pause
            circleTimer.pause()
            pauseButton.setTitle("Resume", for: .normal)
            data.paused = true
        }
    }
}

//
//  TimerStartViewController.swift
//  SimpleTimer
//
//  Created by Maximiliano París Gaete on 5/3/24.
//

import UIKit
import SRCountdownTimer
import UserNotifications
import AudioToolbox


class TimerStartViewController: UIViewController, SRCountdownTimerDelegate, UNUserNotificationCenterDelegate {
    
    //MARK: - Class Variables
    
    var data: Data = Data()
    var start: Date? = nil
    var end: Date? = nil
    
    var circleTimer: SRCountdownTimer = {
        var timer = SRCountdownTimer()
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

    deinit {
        // Remove observers to prevent memory leaks
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        circleTimer.delegate = self
        updateUI()
        insertTimer()
        addObservers()
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
    
    
    // Function to schedule a notification
    func scheduleNotification() {
        // Create content for the notification
        let content = UNMutableNotificationContent()
        content.title = "Timer Done"
        content.body = "Your timer \(data.name!) has finished!"
        content.sound = .default

        // Set the notification to trigger now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        // Create a unique identifier for the notification
        let identifier = "TimerDoneNotification"

        // Create a notification request
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        // Schedule the notification
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled successfully")
            }
        }
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
            pauseButton.tintColor = UIColor(named: "greenApp")
            data.paused = false
        } else { //is not paused
            //pause
            circleTimer.pause()
            pauseButton.setTitle("Resume", for: .normal)
            pauseButton.tintColor = UIColor(named: "blueApp")
            data.paused = true
        }
    }
    
    func timerDidEnd(sender: SRCountdownTimer, elapsedTime: TimeInterval) {
        print("timer ended")
        scheduleNotification()
    }
    
    // Called when a notification is about to be presented to the user while the app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Handle how the notification should be presented
        // For example, you can specify to display an alert and play a sound
        completionHandler([.list, .sound, .banner])
    }
    
    //MARK: - BG/FG
    func addObservers() {
        // Add observers for app entering background and foreground
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    // Called when the app enters the background
    @objc func appDidEnterBackground() {
        start = Date()
        print("- App entered background at \(start?.description ?? "") when timer had \(circleTimer.currentCounterValue) seconds left.")
    }

    // Called when the app enters the foreground
    @objc func appWillEnterForeground() {
        end = Date()
        let timeDifference = end!.timeIntervalSince(start!)
        print("* App will enter foreground at \(end?.description ?? "")")
        print("* time difference = \(timeDifference.description) seconds")
        print("* Starting timer again with \(circleTimer.currentCounterValue - Int(timeDifference)) seconds")
        circleTimer.start(
            beginingValue: data.totalTimeInSeconds!,
            elapsed: data.totalTimeInSeconds! - circleTimer.currentCounterValue + Int(timeDifference),
            total: data.totalTimeInSeconds!
        )
            
    }
}

//
//  ViewController.swift
//  SimpleTimer
//
//  Created by Maximiliano París Gaete on 5/3/24.
//

import UIKit
import RealTimePicker

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var timerName: UITextField!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var startTimerButton: UIButton!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var hoursMinuteStack: UIStackView!
    
    let data = Data()
    
    private var timePicker: RealTimePickerView = {
        let view = RealTimePickerView(format: .h24)
        view.showUnitSeparator = true
        view.rowHeight = 40 // default row height is 60
        view.timeLabelFont = UIFont.systemFont(ofSize: 32, weight: .semibold) // default size
        view.colonLabelFont = UIFont.systemFont(ofSize: 32 * 0.75, weight: .bold) // default size
        view.formatLabelFont = UIFont.systemFont(ofSize: 20, weight: .semibold) // default size
        view.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view.layer.cornerRadius = 24
        view.showCurrentTime = false
        return view
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        timerName.delegate = self
        setupViews()
        timePicker.onNumberTimePicked = { pickedHour, pickedMinute in
            print("hour: \(pickedHour), minute: \(pickedMinute)")
            self.data.hour = pickedHour
            self.data.minute = pickedMinute
        }
        initializeHideKeyboard()
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func setupViews() {
        view.addSubview(timePicker)
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        timePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        timePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        
        
        alertLabel.isHidden = true
        NSLayoutConstraint.activate([
            hoursMinuteStack.bottomAnchor.constraint(equalTo: timePicker.topAnchor, constant: -10),
            hoursMinuteStack.widthAnchor.constraint(equalTo: timePicker.widthAnchor, multiplier: 0.75)
        ])
    }

    
    func initializeHideKeyboard(){
             //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
             let tap: UITapGestureRecognizer = UITapGestureRecognizer(
                 target: self,
                 action: #selector(dismissMyKeyboard)
             )
             //Add this tap gesture recognizer to the parent view
             view.addGestureRecognizer(tap)
     }
    
     @objc func dismissMyKeyboard(){
         //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
         //In short- Dismiss the active keyboard.
         view.endEditing(true)
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destineVC = segue.destination as! TimerStartViewController
        data.name = timerName.text
        destineVC.data = self.data
    }

    @IBAction func startTimerPressed(_ sender: UIButton) {
        if (data.hour == 0 && data.minute == 0){
            alertLabel.isHidden = false
        } else {
            alertLabel.isHidden = true
            performSegue(withIdentifier: "goToTimer", sender: self)
        }
    }
}


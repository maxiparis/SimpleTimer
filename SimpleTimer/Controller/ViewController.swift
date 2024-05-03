//
//  ViewController.swift
//  SimpleTimer
//
//  Created by Maximiliano París Gaete on 5/3/24.
//

import UIKit
import RealTimePicker

class ViewController: UIViewController {
    
    @IBOutlet weak var subView: UIView!
    private var timePicker: RealTimePickerView = {
        let view = RealTimePickerView(format: .h24)
        view.showUnitSeparator = true
        view.rowHeight = 40 // default row height is 60
        view.timeLabelFont = UIFont.systemFont(ofSize: 32, weight: .semibold) // default size
        view.colonLabelFont = UIFont.systemFont(ofSize: 32 * 0.75, weight: .bold) // default size
        view.formatLabelFont = UIFont.systemFont(ofSize: 20, weight: .semibold) // default size
        view.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view.layer.cornerRadius = 24
        view.showCurrentTime = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
//        subView.addSubview(timePicker)
        view.addSubview(timePicker)
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        timePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        timePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
    }

}


//
//  Data.swift
//  SimpleTimer
//
//  Created by Maximiliano París Gaete on 5/4/24.
//

import Foundation

class Data {
    //MARK: - Class variables

    var totalTimeInSeconds: Int?
    var hour: Int = 0 {
        didSet {
            setTotalTimeInSeconds()
        }
    }
    var minute: Int = 0 {
        didSet {
            setTotalTimeInSeconds()
        }
    }
    var name: String?
    
    //MARK: - Initializer / Constructor

    init() {
        
    }
    
    //MARK: - Class methods
    
    func setTotalTimeInSeconds() {
        totalTimeInSeconds = hour*60 + minute
    }
       
    
}

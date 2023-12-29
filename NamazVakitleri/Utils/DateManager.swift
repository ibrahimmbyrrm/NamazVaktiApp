//
//  DateManager.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 18.12.2023.
//

import Foundation
import SwiftDate

protocol DateManagerDelegate : AnyObject {
    func updateTimer(countdownString : String)
    func changeTheDay()
}

protocol DateManagerInterface {
    var delegate : DateManagerDelegate? {get set}
    func calculateTimeRemaining(targetDates : [Date],isToday : Bool)
}

class DateManager : DateManagerInterface {
    
    weak var delegate : DateManagerDelegate?
    
    init(delegate: DateManagerDelegate? = nil) {
        self.delegate = delegate
    }
    
    func calculateTimeRemaining(targetDates : [Date],isToday : Bool) {
        
        var components: DateComponents?
        
        components = isToday ? findClosestDate(in: targetDates) : targetDates[0] - Date.currentDate

        if let components {
            startCountdown(components: components)
        }else {
            delegate?.changeTheDay()
        }
    }
    
    private func findClosestDate(in targetDates: [Date]) -> DateComponents? {
        for date in targetDates {
            if date.isAfterDate(Date.currentDate, granularity: .minute) {
                return date - Date.currentDate
            }
        }
        return nil
    }
    
    private func startCountdown(components: DateComponents) {
        var remainingComponents = components
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            let countdownText = String(format: "%02d:%02d:%02d", remainingComponents.hour ?? 0, remainingComponents.minute ?? 0, remainingComponents.second ?? 0)
            self.delegate?.updateTimer(countdownString: countdownText)
            if remainingComponents.isZero {
                timer.invalidate()
                print("Süre doldu!")
            } else {
                remainingComponents.second = (remainingComponents.second ?? 0) - 1
            }
        }
    }
}

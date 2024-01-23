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
    func getClosestTime(date : Date)
    func timerFinished()
}

protocol DateManagerInterface {
    var delegate : DateManagerDelegate? {get set}
    func setTodayDates(_ todayDates : [Date])
    func setTomorrowDates(_ tomorrowDates : [Date])
    func calculateTimeRemaining()
}

class DateManager : DateManagerInterface {
    
    weak var delegate : DateManagerDelegate?
    
    private var todayDates : [Date] = []
    private var tomorrowDates : [Date] = []
    
    init(delegate: DateManagerDelegate? = nil) {
        self.delegate = delegate
    }
    
    func setTodayDates(_ todayDates : [Date]) {
        self.todayDates = todayDates
    }
    
    func setTomorrowDates(_ tomorrowDates : [Date]) {
        self.tomorrowDates = tomorrowDates
    }
    
    func calculateTimeRemaining() {
        
        var components: DateComponents?
        
        components = findClosestDate(in: self.todayDates)
        
        if let components {
            startCountdown(components: components)
        }else {
            //calculateTimeRemainingForTomorrow(targetDate: tomorrowDates[0])
        }
    }

    private func calculateTimeRemainingForTomorrow(targetDate : Date) {
        guard let dateComponents =  getDateComponents(date: targetDate) else {return}
        startCountdown(components: dateComponents)
    }
    
    private func findClosestDate(in targetDates: [Date]) -> DateComponents? {
        
        for date in targetDates {
            if let component = getDateComponents(date: date) {
                return component
            }else {
                continue
            }
        }
        return nil
    }
    
    private func getDateComponents(date: Date) -> DateComponents? {
        if date.isAfterDate(Date.currentDate, granularity: .minute) {
            delegate?.getClosestTime(date: date)
            return date - Date.currentDate
        }
        return nil
    }

    private func startCountdown(components: DateComponents) {
        var remainingComponents = components
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            if remainingComponents.second == 0 && remainingComponents.minute == 0 && remainingComponents.hour == 0 {
                timer.invalidate()
                delegate?.timerFinished()
            } else {
                if let currentSecond = remainingComponents.second, currentSecond > 0 {
                    remainingComponents.second = currentSecond - 1
                } else if let currentMinute = remainingComponents.minute, currentMinute > 0 {
                    remainingComponents.minute = currentMinute - 1
                    remainingComponents.second = 59
                } else if let currentHour = remainingComponents.hour, currentHour > 0 {
                    remainingComponents.hour = currentHour - 1
                    remainingComponents.minute = 59
                    remainingComponents.second = 59
                }
                
                let countdownText = String(format: Constants.timerTextFormat, remainingComponents.hour ?? 0, remainingComponents.minute ?? 0, remainingComponents.second ?? 0)
                self.delegate?.updateTimer(countdownString: countdownText)
            }
        }
    }
}

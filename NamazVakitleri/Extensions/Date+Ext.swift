//
//  Date+Ext.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 29.12.2023.
//

import SwiftDate
import Foundation

extension Date {
    static var currentDate : Date {
        let timeZone = TimeZone(identifier: "Europe/Istanbul")
        let currentDate = Date()
        let correctedDate = currentDate.addingTimeInterval(TimeInterval(timeZone?.secondsFromGMT(for: currentDate) ?? 0))
        return correctedDate
    }
    
    static var currentDateString : String {
        return Date().toString(.custom("yyyy-MM-dd"))
    }
    
    static var tomorrowDateString : String {
        let tomorrowDate = Date() + 1.days
        return tomorrowDate.toString(.custom("yyyy-MM-dd"))
    }
}

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
        let formatter = DateFormatter()
        let format = "MM-dd-yyyy HH:mm"
        formatter.dateFormat = format
        return formatter.string(from: Date()).toDate(format)?.date ?? Date()
    }
    
    static var currentDateString : String {
        return Date.currentDate.toString(.custom(Constants.yyyyMMdd_Format))
    }
    
    static var tomorrowDateString : String {
        let tomorrowDate = Date() + 1.days
        return tomorrowDate.toString(.custom(Constants.yyyyMMdd_Format))
    }
    
    static func getCurrentDateString() -> String {
        let currentDate = Date.currentDate
        let formatted = currentDate.toString(.custom("MMMM d YYYY EEEE"))
        return formatted
    }
}

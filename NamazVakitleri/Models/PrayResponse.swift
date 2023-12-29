//
//  PrayResponse.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 17.12.2023.
//

import Foundation

struct PrayResponse: Codable {
    let place: Place
    let times: [String: [String]]
}

extension PrayResponse {
    var todatDates : [Date] {
        var list = [Date]()
        for hour in times[Date.currentDateString] ?? [""] {
            list.append("\(Date.currentDateString) \(hour)".formatDate())
        }
        return list
    }
    var tomorrowsDates : [Date] {
        var list = [Date]()
        for hour in times[Date.tomorrowDateString] ?? [""] {
            list.append("\(Date.tomorrowDateString) \(hour)".formatDate())
        }
        return list
    }
}

// MARK: - Place
struct Place: Codable {
    let country, countryCode, city, region: String
    let latitude, longitude: Double
}

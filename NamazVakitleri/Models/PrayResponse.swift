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

// MARK: - Place
struct Place: Codable {
    let country, countryCode, city, region: String
    let latitude, longitude: Double
}

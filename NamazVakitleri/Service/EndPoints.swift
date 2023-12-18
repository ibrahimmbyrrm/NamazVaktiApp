//
//  EndPoints.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 17.12.2023.
//

import Foundation

enum HTTPMethod : String {
    case get = "GET"
    case post = "POST"
}

protocol EndPointType {
    var method : HTTPMethod {get}
    var baseURL : String {get}
    var path : String {get}
    var url : URL? {get}
}

enum EndPointItems<T: Decodable> {
    case timesForCity(String)
    case timesForLocation(Double,Double)
}

extension EndPointItems : EndPointType {
    var method: HTTPMethod {
        .get
    }
    
    var baseURL: String {
        "https://namaz-vakti.vercel.app/api/"
    }
    
    var path: String {
        let currentDate = DateManager.getCurrentDateString()
        switch self {
        case .timesForCity(let city):
            return "timesFromPlace?country=Turkey&region=\(city)&city=\(city)&date=\(currentDate)&days=3&timezoneOffset=180&calculationMethod=Turkey"
        case .timesForLocation(let latitude, let longitude):
            return "timesFromCoordinates?lat=\(latitude.description)&lng=\(longitude.description)&date=\(currentDate)&days=3&timezoneOffset=180&calculationMethod=Turkey"
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    
    
}
//https://namaz-vakti.vercel.app/api/timesFromCoordinates?lat=39.91987&lng=32.85427&date=2023-10-29&days=3&timezoneOffset=180&calculationMethod=Turkey
//https://namaz-vakti.vercel.app/api/timesFromPlace?country=Turkey&region=Iğdır&city=Iğdır&date=2023-10-29&days=3&timezoneOffset=180&calculationMethod=Turkey

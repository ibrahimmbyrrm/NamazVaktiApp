//
//  String+Ext.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 29.12.2023.
//

import Foundation

extension String {
    func formatDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateAndClockFormat
        dateFormatter.timeZone = .init(abbreviation: Constants.gmtTimeZone)
        
        return dateFormatter.date(from: self) ?? Date()
       
    }
}

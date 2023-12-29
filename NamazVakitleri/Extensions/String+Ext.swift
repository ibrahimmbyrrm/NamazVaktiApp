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
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = .init(abbreviation: "GMT")
        
        return dateFormatter.date(from: self) ?? Date()
       
    }
}

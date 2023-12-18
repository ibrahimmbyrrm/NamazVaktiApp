//
//  DateManager.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 18.12.2023.
//

import Foundation

protocol DateManagerDelegate : AnyObject {
    func updateTimer(countdownString : String)
}

class DateManager {
    
    weak var delegate : DateManagerDelegate?
    
    static func getCurrentDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        
        return dateString
    }
    
    func calculateTimeRemaining(targetTimeStrings : [String]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        for targetTimeString in targetTimeStrings {
            if let targetTime = dateFormatter.date(from: targetTimeString) {
                let calendar = Calendar.current
                if let targetDate = calendar.date(bySettingHour: calendar.component(.hour, from: targetTime),
                                                  minute: calendar.component(.minute, from: targetTime),
                                                  second: 0,
                                                  of: Date()) {
                    if findClosestTime(targetDate: targetDate) {
                        startCountdown(from: targetDate)
                        break
                    }
                    
                    
                } else {
                    print("Geçersiz saat formatı")
                }
            }
        }
        
        
    }
    
    func findClosestTime(targetDate : Date) -> Bool {
        
        let currentDate = Date()
        
        // Şuanki tarih ile hedef tarih arasındaki fark
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: currentDate, to: targetDate)
        if components.hour ?? -1 >= 0 {
            return true
        }else {
            return false
        }
    }
    
    func startCountdown(from targetDate: Date) {
        // Timer'ı her saniyede bir çalıştır
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            // Şuanki tarih ve saat
            let currentDate = Date()
            
            // Şuanki tarih ile hedef tarih arasındaki fark
            let components = Calendar.current.dateComponents([.hour, .minute, .second], from: currentDate, to: targetDate)
            // Farkı kullanarak geri sayımı güncelle
            let countdownText = String(format: "%02d:%02d:%02d", components.hour ?? 0, components.minute ?? 0, components.second ?? 0)
            delegate?.updateTimer(countdownString: countdownText)
            print("Geri Sayım: \(countdownText)")
            
            // Hedef tarihe ulaşıldığında timer'ı durdur
            if currentDate >= targetDate {
                timer.invalidate()
                print("Süre doldu!")
            }
        }
    }
}

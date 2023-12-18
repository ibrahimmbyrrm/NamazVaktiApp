//
//  MainViewModel.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 17.12.2023.
//

import Foundation

protocol MainViewModelInterface {
    var delegate : MainControllerInterface? {get set}
    var PrayTimes : PrayResponse {get set}
    
    func viewDidLoad()

}

final class MainViewModel : MainViewModelInterface,DateManagerDelegate {
    
    var PrayTimes: PrayResponse
    
    var dateManager : DateManager
    
    init(PrayTimes: PrayResponse,dateManager : DateManager) {
        self.PrayTimes = PrayTimes
        self.dateManager = dateManager
        dateManager.delegate = self
    }
    
    weak var delegate: MainControllerInterface?
    
    func viewDidLoad() {
        delegate?.refreshUI(timesViewModel: getPrayViewModel(prayResponse: PrayTimes))
        dateManager.calculateTimeRemaining(targetTimeStrings: PrayTimes.times[DateManager.getCurrentDateString()] ?? [""])
    }
    
    func getPrayViewModel(prayResponse : PrayResponse) -> PrayViewModel {
        return PrayViewModel(response: prayResponse)
    }
    
    func updateTimer(countdownString: String) {
        delegate?.refrestTimer(countdownString)
    }
}

final class PrayViewModel {
    
    private var response : PrayResponse
    
    init(response: PrayResponse) {
        self.response = response
    }
}

extension PrayViewModel {
    
    var location : String {
        response.place.city
    }

    var sunset : String {
        response.times[DateManager.getCurrentDateString()]?[0] ?? ""
    }
    
    var fajr : String {
        response.times[DateManager.getCurrentDateString()]?[1] ?? ""
    }
    var dhuhr : String {
        response.times[DateManager.getCurrentDateString()]?[2] ?? ""
    }
    var asr : String {
        response.times[DateManager.getCurrentDateString()]?[3] ?? ""
    }
    var maghrib : String {
        response.times[DateManager.getCurrentDateString()]?[4] ?? ""
    }
    var isha : String {
        response.times[DateManager.getCurrentDateString()]?[5] ?? ""
    }
}

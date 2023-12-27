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
    
    func numberOfRowsInSection() -> Int
    func viewDidLoad()
    func getPrayViewModel() -> PrayViewModel

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
        delegate?.refreshUI(timesViewModel: getPrayViewModel())
        delegate?.setDelegates()
        dateManager.calculateTimeRemaining(targetTimeStrings: PrayTimes.times[DateManager.getCurrentDateString()] ?? [""])
    }
    
    func numberOfRowsInSection() -> Int {
        return getPrayViewModel().numberOfTime
    }
    
    func getPrayViewModel() -> PrayViewModel {
        return PrayViewModel(response: self.PrayTimes)
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
    
    var timeDetails : [TimeDetail] {
        var detailList = [TimeDetail]()
        for i in 0...5 {
            detailList.append(TimeDetail(name: Constants.timeNames[i],
                                         time: response.times[DateManager.getCurrentDateString()]?[i] ?? ""))
        }
        return detailList
    }

    var numberOfTime : Int {
        return 5
    }
}

struct TimeDetail {
    let name : String
    let time : String
}

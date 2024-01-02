//
//  MainViewModel.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 17.12.2023.
//

import Foundation

protocol MainViewModelInterface {
    var delegate : MainControllerInterface? {get set}
    var prayTimes : PrayResponse {get set}
    var closestDateString : String  {get set}
    
    func numberOfRowsInSection() -> Int
    func viewDidLoad()
    func getPrayViewModel() -> PrayViewModel
    func getCurrentDate() -> String

}

final class MainViewModel : MainViewModelInterface,DateManagerDelegate {
    
    var prayTimes: PrayResponse
    
    var dateManager : DateManagerInterface
    var closestDateString : String = ""
    
    init(prayTimes: PrayResponse,dateManager : DateManagerInterface) {
        self.prayTimes = prayTimes
        self.dateManager = dateManager
    }
    
    weak var delegate: MainControllerInterface?
    
    func viewDidLoad() {
        dateManager.delegate = self
        delegate?.refreshUI(timesViewModel: getPrayViewModel())
        delegate?.setDelegates()
        dateManager.calculateTimeRemaining(targetDates: prayTimes.todatDates,isToday: true)
    }
    //MARK: - Pray List Methods
    func numberOfRowsInSection() -> Int {
        return getPrayViewModel().numberOfTime
    }
    
    func getPrayViewModel() -> PrayViewModel {
        return PrayViewModel(response: self.prayTimes)
    }
    //MARK: - DateManager Delegate Functions
    func changeTheDay() {
        dateManager.calculateTimeRemaining(targetDates: prayTimes.tomorrowsDates,isToday: false)
    }
    
    func getCurrentDate() -> String {
        dateManager.getCurrentDateString()
    }
    
    func getClosestTime(date: Date) {
        self.closestDateString = date.toString(.custom(Constants.hourAndMinuteFormat))
    }
    
    func timerFinished() {
        delegate?.timeIsUp()
        dateManager.calculateTimeRemaining(targetDates: prayTimes.todatDates,isToday: true)
    }
   
    func updateTimer(countdownString: String) {
        let closestTime = getPrayViewModel().timeDetails.first(where: {$0.time == self.closestDateString})
        delegate?.refrestTimer("\(closestTime?.name ?? "") Vaktine :\n\(countdownString)")
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
                                         time: response.times[Date.currentDateString]?[i] ?? ""))
        }
        return detailList
    }

    var numberOfTime : Int {
        return 6
    }
}

struct TimeDetail {
    let name : String
    let time : String
}

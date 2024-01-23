//
//  MainViewModel.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 17.12.2023.
//

import Foundation

protocol MainViewModelInterface {
    var delegate : MainControllerInterface? {get set}
    var prayTimes : PrayResponse? {get set}
    var closestDateString : String  {get set}
    
    func numberOfRowsInSection() -> Int
    func viewDidLoad()
    func getPrayViewModel() -> PrayViewModel
}

final class MainViewModel : MainViewModelInterface,DateManagerDelegate {
    
    weak var delegate: MainControllerInterface?
    
    var prayTimes: PrayResponse?
    
    var dateManager : DateManagerInterface
    var closestDateString : String = ""
    var requestType: EndPointItems<PrayResponse>

    /*
     
     1) Network Request tamamlanınca PrayViewModel oluşturulmalı.
     2) Yeni network düzeni için optimizasyon yapılmalı.
     3) Interface protocolleri yeni düzene göre refactor edilmedi.
     4) Yapılan değişiklik bir memory leake sebep olmuş mu test edilmeli.
     5) Login ekranına dönüş için bir buton eklenmeli ve gerekli testler yapılmalı.
     6) Tüm bunlar yapıldıktan sonra projenin mimarisi refactor edilip temizlenmeli.
     7) Side Menu eklenmeli.
     
     */
    
    init(requestType : EndPointItems<PrayResponse>,dateManager : DateManagerInterface) {
        self.dateManager = dateManager
        self.requestType = requestType
        fetchTimes()
    }
    
    ///PrayTimes daha init edilemeden viewDidLoad çağırıldığı için UI a veriler gitmiyor.
    ///AsyncAfter ile delay eklenebilir
    ///PrayTimes init edilene kadar activityIndicator gösterilip request bitene kadar viewdidLoad içindeki logicler çağırılmamalı.
    func fetchTimes() {
        let service : NetworkInterface = NetworkManager()
        
        service.fetchData(type: requestType) { [weak self] result in
            switch result {
            case .success(let response):
                self?.prayTimes = response
                self?.didDownloadData(response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func didDownloadData(_ response : PrayResponse) {
        delegate?.refreshUI(timesViewModel: getPrayViewModel())
        dateManager.setTodayDates(response.todatDates)
        dateManager.setTomorrowDates(response.tomorrowsDates)
        dateManager.calculateTimeRemaining()
        delegate?.stopActivityIndicator()
    }


    func viewDidLoad() {
        dateManager.delegate = self
        delegate?.startActivityIndicator()
        delegate?.setDelegates()
    }
    //MARK: - Pray List Methods
    func numberOfRowsInSection() -> Int {
        return getPrayViewModel().numberOfTime
    }
    
    func getPrayViewModel() -> PrayViewModel {
        return PrayViewModel(response: self.prayTimes)
    }
    //MARK: - DateManager Delegate Functions
    
    func getClosestTime(date: Date) {
        self.closestDateString = date.toString(.custom(Constants.hourAndMinuteFormat))
    }
    
    func timerFinished() {
        delegate?.timeIsUp()
    }
   
    func updateTimer(countdownString: String) {
        let closestTime = getPrayViewModel().timeDetails.first(where: {$0.time == self.closestDateString})
        if let closestTime {
            delegate?.refrestTimer("\(closestTime.name) Vaktine :\n\(countdownString)")
        }else {
            delegate?.refrestTimer("\(Constants.timeNames[0]) Vaktine :\n\(countdownString)")
        }
        
    }
}

final class PrayViewModel {
    
    private var response : PrayResponse?
    
    init(response: PrayResponse?) {
        self.response = response
    }
}

extension PrayViewModel {
    
    var location : String {
        response?.place.city ?? ""
    }
    
    var timeDetails : [TimeDetail] {
        var detailList = [TimeDetail]()
        for i in 0...5 {
            detailList.append(TimeDetail(name: Constants.timeNames[i],
                                         time: response?.times[Date.currentDateString]?[i] ?? ""))
        }
        return detailList
    }
    
    var tomorrowDetails : [TimeDetail] {
        var detailList = [TimeDetail]()
        for i in 0...5 {
            detailList.append(TimeDetail(name: Constants.timeNames[i],
                                         time: response?.times[Date.tomorrowDateString]?[i] ?? ""))
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

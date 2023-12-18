//
//  LoginViewModel.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 17.12.2023.
//

import Foundation
import CoreLocation

enum RequestType {
    case location
    case city
}

struct UserLocation {
    var latitude : Double
    var longitude : Double
}

protocol LoginViewModelInterface {
    var delegate : LoginControllerInterface? {get set}
    var selectedCity : String {get set}
    var userLocation : UserLocation {get set}
    
    
    func submitButtonTapped(type : RequestType)
    func viewDidLoad()
    func setSelectedCity(_ row : Int)
    func cityTitleForRow(_ index : Int) -> String
    func getTheNumberOfCities() -> Int
    func getUsersLocation()
}

final class LoginViewModel : NSObject, LoginViewModelInterface{
    
    weak var delegate: LoginControllerInterface?
    
    var service : NetworkInterface
    
    init(service : NetworkInterface) {
        self.service = service
    }
    
    var selectedCity: String = ""
    var userLocation: UserLocation = UserLocation(latitude: 42, longitude: 39)
    
    var locationManager = CLLocationManager()
    
    func getUsersLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func fetchPrayTimes(fetchMethod : RequestType) {
        let endpoint = fetchMethod == .city ? EndPointItems<PrayResponse>.timesForCity(self.selectedCity) : EndPointItems<PrayResponse>.timesForLocation(userLocation.latitude, userLocation.longitude)
        
        service.fetchData(type: endpoint) { result in
            switch result {
            case .success(let response):
                self.delegate?.stopActivityIndicator()
                self.delegate?.initializeMainControllerAndNavigate(times: response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func submitButtonTapped(type : RequestType) {
        delegate?.startActivityIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.fetchPrayTimes(fetchMethod: type)
        }
    }
    
    func setSelectedCity(_ row : Int) {
        self.selectedCity = Cities.allCases[row].rawValue
    }
    
    func viewDidLoad() {
        delegate?.setupButtonActions()
        delegate?.setDelegates()
    }
    
    func getTheNumberOfCities() -> Int {
        return Cities.allCases.count
    }
    
    func cityTitleForRow(_ index : Int) -> String {
        return Cities.allCases[index].rawValue
    }
}

extension LoginViewModel : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let longitude = location.coordinate.longitude.magnitude
            let latitude = location.coordinate.latitude.magnitude
            self.userLocation = UserLocation(latitude: latitude, longitude: longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

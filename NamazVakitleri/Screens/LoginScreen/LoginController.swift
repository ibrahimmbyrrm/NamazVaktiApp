//
//  ViewController.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 16.12.2023.
//

import UIKit

protocol LoginControllerInterface : AnyObject {
    func setupButtonActions()
    func setDelegates()
    func startActivityIndicator()
    func stopActivityIndicator()
    func refreshPicker()
    func initializeMainControllerAndNavigate(times : PrayResponse)
}

final class LoginController: BaseViewController<LoginView>, LoginControllerInterface {
    
    private var viewModel : LoginViewModelInterface = LoginViewModel(service: NetworkManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
    func setDelegates() {
        rootView.box1.setPickerDelegate(delegate: self, dataSource: self)
    }
    
    func refreshPicker() {
        rootView.box1.pickerView.reloadAllComponents()
    }
    
    func setupButtonActions() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(boxTapped))
        rootView.box1.addGestureRecognizer(gesture)
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(secondBoxTapped))
        rootView.box2.addGestureRecognizer(gesture2)
        rootView.submitButton.addTarget(nil, action: #selector(submitButtonTapped), for: .touchUpInside)
        rootView.box1.doneButton.addTarget(nil, action: #selector(citySelectionEnded), for: .touchUpInside)
    }
    
    func startActivityIndicator() {
        rootView.activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        rootView.activityIndicator.stopAnimating()
        
    }
    
    func initializeMainControllerAndNavigate(times: PrayResponse) {
        let mainController = MainController()
        mainController.modalPresentationStyle = .fullScreen
        mainController.viewModel = MainViewModel(PrayTimes: times,dateManager: DateManager())
        present(mainController, animated: true)
    }
    
    
    @objc func submitButtonTapped() {
        if rootView.box2.isExpanded {
            viewModel.getUsersLocation()
            viewModel.submitButtonTapped(type: .location)
        }else {
            viewModel.submitButtonTapped(type: .city)
        }
    }
    
    @objc func citySelectionEnded() {
        rootView.box1.didSelect(result: viewModel.selectedCity)
    }
    
    @objc func secondBoxTapped() {
        rootView.locationTapped()
    }
    
    @objc func boxTapped() {
        rootView.manualTapped()
    }
}

extension LoginController : UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.getTheNumberOfCities()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.cityTitleForRow(row)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.setSelectedCity(row)
    }
    
}


//
//  ViewController.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 16.12.2023.
//

import UIKit

protocol LoginControllerInterface : AnyObject {
    func setupButtonActions()
    func initializeMainControllerAndNavigate(vc : MainController)
}

protocol CityPickerDelegate : AnyObject {
    func didFinishSelectCity(city : String)
}

final class LoginController: BaseViewController<LoginView>, LoginControllerInterface,CityPickerDelegate {
    
    private var viewModel : LoginViewModelInterface = LoginViewModel(service: NetworkManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
    func setupButtonActions() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(boxTapped))
        rootView.box1.addGestureRecognizer(gesture)
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(secondBoxTapped))
        rootView.box2.addGestureRecognizer(gesture2)
        rootView.submitButton.addTarget(nil, action: #selector(submitButtonTapped), for: .touchUpInside)
    }
    
    func initializeMainControllerAndNavigate(vc : MainController) {
        navigationController?.show(vc, sender: nil)
    }
    
    func didFinishSelectCity(city: String) {
        rootView.box1.didSelect(result: city)
        viewModel.setSelectedCity(city)
    }
    
    
    @objc func submitButtonTapped() {
        if rootView.box2.isExpanded {
            viewModel.getUsersLocation()
            viewModel.submitButtonTapped(type: .location)
        }else {
            viewModel.submitButtonTapped(type: .city)
        }
    }
    
    @objc func secondBoxTapped() {
        rootView.locationTapped()
    }
    
    @objc func boxTapped() {
        rootView.manualTapped()
        let picker = CityPickerView()
        picker.delegate = self
        present(picker, animated: true)
    }
}



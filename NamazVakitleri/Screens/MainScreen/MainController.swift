//
//  MainController.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 17.12.2023.
//

import UIKit

protocol MainControllerInterface : AnyObject {
    func refreshUI(timesViewModel : PrayViewModel)
    func refrestTimer(_ time : String)
}

final class MainController : BaseViewController<MainView>,MainControllerInterface {
    
    var viewModel : MainViewModelInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
    func refreshUI(timesViewModel: PrayViewModel) {
    }
    
    func refrestTimer(_ time: String) {
        rootView.timer.text = time
    }
    
    func findClosest() {
        
    }
}

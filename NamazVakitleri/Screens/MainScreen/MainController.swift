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
    
    func setDelegates()
}

final class MainController : BaseViewController<MainView>,MainControllerInterface {
    
    var viewModel : MainViewModelInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
    func setDelegates() {
        rootView.timesTableView.delegate = self
        rootView.timesTableView.dataSource = self
    }
    
    func refreshUI(timesViewModel: PrayViewModel) {
    }
    
    func refrestTimer(_ time: String) {
        rootView.timer.text = " \(viewModel.getPrayViewModel().location) \n \(time)"
    }

}
extension MainController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath) as! TimeCell
        let timesViewModel = viewModel.getPrayViewModel()
        cell.setTimes(timeDetail: timesViewModel.timeDetails[indexPath.row])
        return cell
    }
}

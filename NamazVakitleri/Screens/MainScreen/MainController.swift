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
    func startActivityIndicator()
    func stopActivityIndicator()
    func setDelegates()
    func timeIsUp()
}

final class MainController : BaseViewController<MainView>,MainControllerInterface {
    
    var viewModel : MainViewModelInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }

    func timeIsUp() {
        for cell in rootView.timesTableView.visibleCells {
            if let cell = cell as? TimeCell {
                cell.animateCurrentTime()
            }else {
                print("cast edilemedi")
            }
        }
    }
    
    func startActivityIndicator() {
        rootView.activityIndicator.startAnimating()
        rootView.timesTableView.isHidden = true
    }
    
    func stopActivityIndicator() {
        rootView.activityIndicator.stopAnimating()
        rootView.timesTableView.isHidden = false
    }
    
    func setDelegates() {
        rootView.timesTableView.delegate = self
        rootView.timesTableView.dataSource = self
    }
    
    func refreshUI(timesViewModel: PrayViewModel) {
        rootView.currentDateLabel.set(text: viewModel.getPrayViewModel().location,rightIcon: UIImage(systemName: "location.circle"))
        rootView.timesTableView.reloadData()
    }
    
    func refrestTimer(_ time: String) {
        rootView.timer.text = time
    }

}
extension MainController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath) as! TimeCell
        let timesViewModel = viewModel.getPrayViewModel()
        let isClosest = viewModel.closestDateString == timesViewModel.timeDetails[indexPath.row].time
            cell.setTimes(timeDetail: timesViewModel.timeDetails[indexPath.row],isClosest: isClosest)
            return cell
        }
}

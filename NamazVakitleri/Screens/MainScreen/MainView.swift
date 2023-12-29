//
//  MainView.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 17.12.2023.
//

import UIKit

final class MainView : UIView {
    
    lazy var timer : UILabel = {
       let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 30)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var timesTableView : UITableView = {
        let tableview = UITableView()
        tableview.register(TimeCell.self, forCellReuseIdentifier: "timeCell")
        tableview.isScrollEnabled = false
        tableview.separatorStyle = .none
        tableview.layer.cornerRadius = 20
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        addSubview(timer)
        addSubview(timesTableView)
        NSLayoutConstraint.activate([
            timer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timer.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            
            timesTableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timesTableView.topAnchor.constraint(equalTo: timer.bottomAnchor, constant: 20),
            timesTableView.widthAnchor.constraint(equalToConstant: 250),
            timesTableView.heightAnchor.constraint(equalToConstant: 250),
            
        ])
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
}

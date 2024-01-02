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
        label.textColor = .white
        label.font = .systemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var currentDateLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var timesTableView : UITableView = {
        let tableview = UITableView()
        tableview.register(TimeCell.self, forCellReuseIdentifier: "timeCell")
        tableview.isScrollEnabled = false
        tableview.separatorStyle = .singleLine
        tableview.separatorColor = .palette3
        tableview.layer.cornerRadius = 20
        tableview.allowsSelection = false
        tableview.layer.borderColor = UIColor.palette3.cgColor
        tableview.layer.borderWidth = 3
        tableview.backgroundColor = .clear
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    lazy var backgroundImage : UIImageView = {
        let imageview = UIImageView(image: .homeBackground)
        imageview.contentMode = .scaleAspectFill
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
        setupBackgroundImageViewConstraints()
        setupTimerConstraints()
        setupTimesTableViewConstraints()
    }
    
    private func addSubviews() {
        [backgroundImage,currentDateLabel,timer,timesTableView].forEach({addSubview($0)})
    }
    
    private func setupTimerConstraints() {
        NSLayoutConstraint.activate([
            timer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timer.topAnchor.constraint(equalTo: currentDateLabel.bottomAnchor, constant: 30),
            currentDateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            currentDateLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
    }
    
    private func setupBackgroundImageViewConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            
        ])
    }
    
    private func setupTimesTableViewConstraints() {
        NSLayoutConstraint.activate([
            timesTableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timesTableView.topAnchor.constraint(equalTo: timer.bottomAnchor, constant: 20),
            timesTableView.widthAnchor.constraint(equalToConstant: 300),
            timesTableView.heightAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
}

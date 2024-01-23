//
//  MainView.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 17.12.2023.
//

import UIKit

final class MainView : UIView {
    
    lazy var activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        return activityIndicator
    }()
    
    lazy var timer : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var currentDateLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.backgroundColor = .gray
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        label.textAlignment = .center
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
        return tableview
    }()
    
    lazy var backgroundImage : UIImageView = {
        let imageview = UIImageView(image: .homeBackground)
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
        setupActivityIndicatorConstraints()
        setupBackgroundImageViewConstraints()
        setupTimerConstraints()
        setupTimesTableViewConstraints()
    }
    
    private func addSubviews() {
        [backgroundImage,currentDateLabel,timer,timesTableView,activityIndicator].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        })
    }
    
    private func setupActivityIndicatorConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
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
extension UILabel {

    func set(text:String, leftIcon: UIImage? = nil, rightIcon: UIImage? = nil) {

        let leftAttachment = NSTextAttachment()
        leftAttachment.image = leftIcon
        leftAttachment.bounds = CGRect(x: 0, y: -2.5, width: 20, height: 20)
        if let leftIcon = leftIcon {
            leftAttachment.bounds = CGRect(x: 0, y: -2.5, width: leftIcon.size.width, height: leftIcon.size.height)
        }
        let leftAttachmentStr = NSAttributedString(attachment: leftAttachment)

        let myString = NSMutableAttributedString(string: "")
        
        let rightAttachment = NSTextAttachment()
        rightAttachment.image = rightIcon
        rightAttachment.bounds = CGRect(x: 0, y: -5, width: 20, height: 20)
        let rightAttachmentStr = NSAttributedString(attachment: rightAttachment)


        if semanticContentAttribute == .forceRightToLeft {
            if rightIcon != nil {
                myString.append(rightAttachmentStr)
                myString.append(NSAttributedString(string: " "))
            }
            myString.append(NSAttributedString(string: text))
            if leftIcon != nil {
                myString.append(NSAttributedString(string: " "))
                myString.append(leftAttachmentStr)
            }
        } else {
            if leftIcon != nil {
                myString.append(leftAttachmentStr)
                myString.append(NSAttributedString(string: " "))
            }
            myString.append(NSAttributedString(string: text))
            if rightIcon != nil {
                myString.append(NSAttributedString(string: " "))
                myString.append(rightAttachmentStr)
            }
        }
        attributedText = myString
    }
}

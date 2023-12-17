//
//  LoginView.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 16.12.2023.
//

import UIKit

final class LoginView: UIView {
    //MARK: - UI Objects
    private lazy var mosqueIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mosque"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var appTitle : UILabel = {
        let label = UILabel()
        label.text = "Prayer Reminder"
        label.font = .italicSystemFont(ofSize: 30)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var box1 = CitySelectionBox()
    lazy var box2 = LocationBox()
    
    lazy var submitButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.setTitle("Continue", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 30
        button.isEnabled = false
        button.layer.opacity = 0.4
        return button
    }()
    
    private var heightConstraint = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupMosqueIconConstraints()
        setupAppTitleConstraints()
        setupCityBoxConstraints()
        setupLocationBoxConstraints()
        setupSubmitButtonConstraints()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}

    //MARK: - Layout Functions
    private func addSubviews() {
        [mosqueIcon,box1,box2,appTitle,submitButton].forEach({
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
    }
    
    
    private func setupMosqueIconConstraints() {
        NSLayoutConstraint.activate([
            mosqueIcon.widthAnchor.constraint(equalToConstant: 100),
            mosqueIcon.heightAnchor.constraint(equalToConstant: 100),
            mosqueIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mosqueIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: -150)
        ])
    }
    
    private func setupLocationBoxConstraints() {
        NSLayoutConstraint.activate([
            box2.topAnchor.constraint(equalTo: box1.bottomAnchor, constant: 5),
            box2.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            box2.widthAnchor.constraint(equalToConstant: 353),
            box2.heightAnchor.constraint(equalToConstant: 88)
        ])
    }
    
    private func setupAppTitleConstraints() {
        NSLayoutConstraint.activate([
            appTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            appTitle.topAnchor.constraint(equalTo: mosqueIcon.bottomAnchor, constant: 10)
        ])
    }
    
    private func setupSubmitButtonConstraints() {
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: box2.bottomAnchor, constant: 20),
            submitButton.widthAnchor.constraint(equalToConstant: 242),
            submitButton.heightAnchor.constraint(equalToConstant: 75),
            submitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func setupCityBoxConstraints() {
        heightConstraint = box1.heightAnchor.constraint(equalToConstant: 88)
        NSLayoutConstraint.activate([
            box1.topAnchor.constraint(equalTo: appTitle.bottomAnchor, constant: 40),
            box1.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            box1.widthAnchor.constraint(equalToConstant: 353),
            heightConstraint
        ])
    }
    //MARK: - Segment Change Functions
    func manualTapped() {
        submitButton.isEnabled = true
        submitButton.layer.opacity = 1
        UIView.animate(withDuration: 0.35) {
            self.box1.isExpanded = true
            self.box2.isExpanded = false
            if self.box1.isExpanded {
                self.heightConstraint.constant = 140
            }else {
                self.heightConstraint.constant = 88
            }
            self.layoutIfNeeded()
        }
    }
    
    func locationTapped() {
        submitButton.isEnabled = true
        submitButton.layer.opacity = 1
        UIView.animate(withDuration: 0.35) {
            self.box1.isExpanded = false
            self.box2.isExpanded = true
            if self.box1.isExpanded {
                self.heightConstraint.constant = 140
            }else {
                self.heightConstraint.constant = 88
            }
            self.layoutIfNeeded()
        }
    }
}



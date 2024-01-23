//
//  LoginSelectionBox.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 16.12.2023.
//

import UIKit

extension UIView {
    func addSubviews(views : [UIView]) {
        views.forEach({addSubview($0)})
    }
}

class CitySelectionBox : UIView {
    
    var isExpanded = false {
        didSet {
            self.boxExpanded()
        }
    }
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Select your city manually."
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    lazy var textField : UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = CGColor(red: 122/255, green: 159/255, blue: 1, alpha: 1)
        textField.layer.borderWidth = 2
        textField.textAlignment = .center
        textField.placeholder = "Ankara"
        textField.isEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    var centerXConstraint = NSLayoutConstraint()
    var centerYConstraint = NSLayoutConstraint()
    
    private func commonInit() {
        addSubviews(views: [titleLabel,textField])
        textField.isHidden = true
        
        centerXConstraint = titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor,constant: 0)
        centerYConstraint = titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 0)
        backgroundColor = UIColor.white
        layer.borderColor = UIColor.palette2.cgColor
        layer.borderWidth = 4
        layer.cornerRadius = 20.0 // Köşe yuvarlatma miktarını ayarlayın
        layer.masksToBounds = true // Köşe yuvarlatma sınırlarını belirtilen sınırlar içinde tutar
        
        NSLayoutConstraint.activate([
            centerXConstraint,
            centerYConstraint,
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            textField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: 260),
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }

    
    func boxExpanded() {
        UIView.animate(withDuration: 0.5) { 
            if self.isExpanded {
                self.textField.isHidden = false
                self.centerXConstraint.constant = -50
                self.centerYConstraint.constant = -40
                self.layer.borderColor = UIColor.palette1.cgColor
            }else {
                self.textField.isHidden = true
                self.centerXConstraint.constant = 0
                self.centerYConstraint.constant = 0
                self.layer.borderColor = UIColor.palette2.cgColor
            }
        }
        
    }
    
    func didSelect(result : String) {
        self.textField.text = result
        self.textField.resignFirstResponder()
    }
}

//
//  LocationBox.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 17.12.2023.
//

import UIKit

class LocationBox : UIView {
    
    var isExpanded = false {
        didSet {
            self.boxExpanded()
        }
    }
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Use my current location."
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(titleLabel)
        backgroundColor = UIColor.white
        layer.borderColor = UIColor.palette2.cgColor
        layer.borderWidth = 4
        layer.cornerRadius = 20.0 // Köşe yuvarlatma miktarını ayarlayın
        layer.masksToBounds = true // Köşe yuvarlatma sınırlarını belirtilen sınırlar içinde tutar
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor,constant: 0),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 0),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func boxExpanded() {
        self.layer.borderColor = isExpanded ? UIColor.palette1.cgColor : UIColor.palette2.cgColor
    }
}

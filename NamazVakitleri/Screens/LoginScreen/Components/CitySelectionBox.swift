//
//  LoginSelectionBox.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 16.12.2023.
//

import UIKit

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
        return textField
    }()
    
    lazy var doneButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .blue
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let pickerView = UIPickerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        textField.inputView = pickerView
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    var centerXConstraint = NSLayoutConstraint()
    var centerYConstraint = NSLayoutConstraint()
    
    private func commonInit() {
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(doneButton)
        textField.isHidden = true
        doneButton.isHidden = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        // Bu kısımda görünümünüzü özelleştirebilirsiniz
        
        centerXConstraint = titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor,constant: 0)
        centerYConstraint = titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 0)
        backgroundColor = UIColor.white
        layer.borderColor = CGColor(red: 122/255, green: 159/255, blue: 1, alpha: 1)
        layer.borderWidth = 4
        layer.cornerRadius = 20.0 // Köşe yuvarlatma miktarını ayarlayın
        layer.masksToBounds = true // Köşe yuvarlatma sınırlarını belirtilen sınırlar içinde tutar
        
        NSLayoutConstraint.activate([
            centerXConstraint,
            centerYConstraint,
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            textField.centerXAnchor.constraint(equalTo: self.centerXAnchor,constant: -20),
            textField.widthAnchor.constraint(equalToConstant: 260),
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            doneButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 3),
            doneButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            doneButton.widthAnchor.constraint(equalToConstant: 50),
            doneButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func boxExpanded() {
        UIView.animate(withDuration: 0.5) {
            if self.isExpanded {
                self.doneButton.isHidden = false
                self.textField.isHidden = false
                self.centerXConstraint.constant = -50
                self.centerYConstraint.constant = -40
                self.layer.borderColor = UIColor.blue.cgColor
            }else {
                self.textField.isHidden = true
                self.doneButton.isHidden = true
                self.centerXConstraint.constant = 0
                self.centerYConstraint.constant = 0
                self.layer.borderColor = CGColor(red: 122/255, green: 159/255, blue: 1, alpha: 1)
            }
        }
        
    }
    
    func setPickerDelegate(delegate : UIPickerViewDelegate,dataSource : UIPickerViewDataSource) {
        self.pickerView.delegate = delegate
        self.pickerView.dataSource = dataSource
    }
    
    func didSelect(result : String) {
        self.textField.text = result
        self.textField.resignFirstResponder()
    }
}

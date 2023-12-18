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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        addSubview(timer)
        NSLayoutConstraint.activate([
            timer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timer.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            
        ])
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
}

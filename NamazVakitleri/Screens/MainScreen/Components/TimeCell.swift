//
//  TimeCell.swift
//  NamazVakitleri
//
//  Created by İbrahim Bayram on 27.12.2023.
//

import UIKit

class TimeCell: UITableViewCell {
    
    private lazy var timeNameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    private lazy var timeLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(timeNameLabel)
        addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10),
            timeLabel.heightAnchor.constraint(equalToConstant: 30),
            timeLabel.widthAnchor.constraint(equalToConstant: 100),
            
            timeNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            timeNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            timeNameLabel.heightAnchor.constraint(equalToConstant: 30),
            timeNameLabel.widthAnchor.constraint(equalToConstant: 100),
        
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTimes(timeDetail : TimeDetail) {
        self.timeNameLabel.text = timeDetail.name
        self.timeLabel.text = timeDetail.time
        
    }

}

//
//  RoomsTableViewCell.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/22.
//

import UIKit

class RoomsTableViewCell: UITableViewCell {
    
    static let identifier: String = "roomsTableViewCell"
    
    var name = "" // 나중에 지울 때 사용
    
    let profileImageView1 : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let profileImageView2 : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let imageStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
       return stackView
    }()
    
    let totalCountOfPeopleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let placeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setupView() {
        
        [profileImageView1, profileImageView2].forEach {
            imageStackView.addArrangedSubview($0)
        }
        
        self.addSubview(imageStackView)
        self.addSubview(totalCountOfPeopleLabel)
        self.addSubview(placeLabel)
        self.addSubview(timeLabel)
        
        
    }
    
    // MARK: AutoLayout
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            imageStackView.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -100),
            
            totalCountOfPeopleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            totalCountOfPeopleLabel.leadingAnchor.constraint(equalTo: imageStackView.trailingAnchor, constant: 20),
            
            timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            
            placeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            placeLabel.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 20),
            placeLabel.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: 20)
        ])
    }
    
}

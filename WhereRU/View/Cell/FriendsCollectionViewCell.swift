//
//  FriendsCollectionViewCell.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/02.
//

import UIKit

class FriendsCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "friendsCollectionViewCell"
    
    let deleteButton : UIButton = {
        let button = UIButton()
        button.tintColor = .systemRed
        return button
    }()
    
    let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setupView() {
        
        self.addSubview(deleteButton)
        self.addSubview(profileImageView)
        self.addSubview(nameLabel)
        
        
    }
    
    // MARK: AutoLayout
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            deleteButton.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            deleteButton.bottomAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 10),
            profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10)
        ])
    }
}

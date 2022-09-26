//
//  EnteredRoomFriendsCollectionViewCell.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/26.
//

import UIKit

class EnteredRoomFriendsCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "addedFriendsCollectionViewCell"
    
    let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nickNameLabel : UILabel = {
        let label = UILabel()
        label.text = "test"
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
        
        self.addSubview(profileImageView)
        self.addSubview(nickNameLabel)
        
    }
    
    // MARK: AutoLayout
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            nickNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            nickNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

//
//  FriendsTableViewCell.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/02.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {
    
    static let identifier: String = "friendsTableViewCell"
    
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
        
        self.addSubview(profileImageView)
        self.addSubview(nickNameLabel)
        
        
    }
    
    // MARK: AutoLayout
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            nickNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nickNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
    }
}

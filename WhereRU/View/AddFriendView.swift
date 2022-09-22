//
//  AddFriendView.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/15.
//

import UIKit

class AddFriendView: UIView {
    
    let friendTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: FriendsTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        self.addSubview(friendTableView)
    }
    
    // MARK: AutoLayout
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            friendTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            friendTableView.topAnchor.constraint(equalTo: self.topAnchor),
            friendTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            friendTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

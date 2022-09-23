//
//  RoomsView.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/01.
//

import UIKit

class RoomsView: UIView {
    
    let roomTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(RoomsTableViewCell.self, forCellReuseIdentifier: RoomsTableViewCell.identifier)
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
        
        self.addSubview(roomTableView)
    }
    
    // MARK: AutoLayout
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            roomTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            roomTableView.topAnchor.constraint(equalTo: self.topAnchor),
            roomTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            roomTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
}

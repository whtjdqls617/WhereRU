//
//  EtcView.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/22.
//

import UIKit

class EtcView: UIView {
    
    let logoutButton : UIButton = {
       let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        self.addSubview(logoutButton)
    }
    
    // MARK: AutoLayout
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

}

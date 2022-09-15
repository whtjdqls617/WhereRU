//
//  AddFriendView.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/15.
//

import UIKit

class AddFriendView: UIView {
    
    let searchTextField : UITextField = {
       let textField = UITextField()
        textField.placeholder = "이메일을 입력해주세요."
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let nickNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addButton : UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.backgroundColor = .systemGreen
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let userStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        
        [nickNameLabel, addButton].forEach {
            userStackView.addArrangedSubview($0)
        }
        self.addSubview(searchTextField)
        self.addSubview(userStackView)
    }
    
    // MARK: AutoLayout
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: self.topAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            searchTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 40),
            searchTextField.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 100),
            
            userStackView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            userStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            userStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

}

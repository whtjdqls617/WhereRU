//
//  CreateRoomView.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/02.
//

import UIKit

class CreateRoomView: UIView {
    
    let friendsCollecionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let placeLabel : UILabel = {
        let label = UILabel()
        label.text = "장소"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let placeInputLabel : UILabel = {
        let label = UILabel()
        label.text = "선택"
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let placeStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let moneyLabel : UILabel = {
        let label = UILabel()
        label.text = "돈"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let moneyInputTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "금액을 입력해 주세요."
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let moneyStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let createButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("생성", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cancleButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray
        button.setTitle("취소", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let buttonStackView : UIStackView = {
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
        
        [placeLabel, placeInputLabel].forEach {
            placeStackView.addArrangedSubview($0)
        }
        
        [moneyLabel, moneyInputTextField].forEach {
            moneyStackView.addArrangedSubview($0)
        }
        
        [cancleButton, createButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        self.addSubview(friendsCollecionView)
        self.addSubview(placeStackView)
        self.addSubview(moneyStackView)
        self.addSubview(buttonStackView)
        
    }
    
    // MARK: AutoLayout
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            friendsCollecionView.topAnchor.constraint(equalTo: self.topAnchor),
            friendsCollecionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            friendsCollecionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            friendsCollecionView.bottomAnchor.constraint(equalTo: self.centerYAnchor),
            
            placeStackView.topAnchor.constraint(equalTo: friendsCollecionView.bottomAnchor),
            placeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            placeStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20),
            
            moneyStackView.topAnchor.constraint(equalTo: placeStackView.bottomAnchor, constant: 30),
            moneyStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            moneyStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20),
            
            buttonStackView.topAnchor.constraint(equalTo: moneyStackView.bottomAnchor, constant: 50),
            buttonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            buttonStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

}

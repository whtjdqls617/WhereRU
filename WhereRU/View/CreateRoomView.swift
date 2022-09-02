//
//  CreateRoomView.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/02.
//

import UIKit

class CreateRoomView: UIView {
    
    let friendListLabel : UILabel = {
        let label = UILabel()
        label.text = "친구 선택"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let friendsCollecionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let placeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "장소"
        return label
    }()
    
    let placeInputLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "선택"
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
    
    let moneyInputLabel : UILabel = {
        let label = UILabel()
        label.text = "입력"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let moneyStackView : UIStackView = {
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
        
        [moneyLabel, moneyInputLabel].forEach {
            moneyStackView.addArrangedSubview($0)
        }
        
        self.addSubview(friendListLabel)
        self.addSubview(friendsCollecionView)
        self.addSubview(placeStackView)
        self.addSubview(moneyStackView)
    }
    
    // MARK: AutoLayout
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            friendListLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            friendListLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            
            friendsCollecionView.topAnchor.constraint(equalTo: friendListLabel.bottomAnchor, constant: 20),
            friendsCollecionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            friendsCollecionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            friendsCollecionView.bottomAnchor.constraint(equalTo: self.centerYAnchor),
            
            placeStackView.topAnchor.constraint(equalTo: friendsCollecionView.bottomAnchor, constant: 20),
            placeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            placeStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20),
            
            moneyStackView.topAnchor.constraint(equalTo: placeStackView.bottomAnchor, constant: 20),
            moneyStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            moneyStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20)
        ])
    }

}

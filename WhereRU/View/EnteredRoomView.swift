//
//  EnteredRoomView.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/25.
//

import UIKit

class EnteredRoomView: UIView {

    let friendsCollecionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(EnteredRoomFriendsCollectionViewCell.self, forCellWithReuseIdentifier: EnteredRoomFriendsCollectionViewCell.identifier)
        collectionView.collectionViewLayout.invalidateLayout()
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
    
    let moneyInputLabel : UILabel = {
        let textField = UILabel()
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
    
    let arriveButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("도착", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let arriveStatusImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        
        self.addSubview(friendsCollecionView)
        self.addSubview(placeStackView)
        self.addSubview(moneyStackView)
        self.addSubview(arriveButton)
        self.addSubview(arriveStatusImageView)
        
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
            
            arriveButton.topAnchor.constraint(equalTo: moneyStackView.bottomAnchor, constant: 50),
            arriveButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            arriveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            arriveStatusImageView.topAnchor.constraint(equalTo: arriveButton.bottomAnchor, constant: 30),
            arriveStatusImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

}

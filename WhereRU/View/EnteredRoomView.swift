//
//  EnteredRoomView.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/25.
//

import UIKit
import GoogleMaps
import CoreLocation

class EnteredRoomView: UIView {
    
    let locationManager = CLLocationManager()
    
    let friendsCollecionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(EnteredRoomFriendsCollectionViewCell.self, forCellWithReuseIdentifier: EnteredRoomFriendsCollectionViewCell.identifier)
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var mapView : GMSMapView = {
        let latitude = locationManager.location?.coordinate.latitude ?? 0.0
        let longitude = locationManager.location?.coordinate.longitude ?? 0.0
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 17.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
//        mapView.settings.myLocationButton = true
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        mapView.isMyLocationEnabled = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
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
        self.addSubview(mapView)
        self.addSubview(placeStackView)
        self.addSubview(moneyStackView)
        self.addSubview(arriveButton)
        self.addSubview(arriveStatusImageView)
        
    }
    
    // MARK: AutoLayout
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            friendsCollecionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            friendsCollecionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            friendsCollecionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            friendsCollecionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 80),
            
            mapView.topAnchor.constraint(equalTo: friendsCollecionView.bottomAnchor, constant: 10),
            mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: placeStackView.topAnchor, constant: -20),
            
            placeStackView.topAnchor.constraint(equalTo: moneyStackView.topAnchor, constant: -40),
            placeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            placeStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20),
            placeStackView.bottomAnchor.constraint(equalTo: moneyStackView.topAnchor, constant: -20),
            
            moneyStackView.topAnchor.constraint(equalTo: arriveButton.topAnchor, constant: -40),
            moneyStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            moneyStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20),
            moneyStackView.bottomAnchor.constraint(equalTo: arriveButton.topAnchor, constant: -20),
            
            arriveButton.topAnchor.constraint(equalTo: arriveStatusImageView.topAnchor, constant: -40),
            arriveButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            arriveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            arriveButton.bottomAnchor.constraint(equalTo: arriveStatusImageView.topAnchor, constant: -20),
            
            arriveStatusImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            arriveStatusImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            arriveStatusImageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

}

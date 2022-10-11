//
//  EnteredRoomViewController.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/25.
//

import UIKit
import KakaoSDKFriend
import Combine
import GoogleMaps
import GooglePlaces

class EnteredRoomViewController: BaseViewController {
    
    var friends : [[String : String?]]?
    var ids : [String] = []
    var placeName : String = ""
    var placeCoordinate = [Double]()
    var money : Int = 0
    var roomName : String = ""
    var notificationKey : String = ""
        
    var friendsStatus : [FriendInRoom]?
    private var disposalbleBag = Set<AnyCancellable>()
    
    let enteredRoomView = EnteredRoomView()
    let enteredRoomViewModel = EnteredRoomViewModel()
    let findPlaceViewController = FindPlaceViewController()
    
    override func loadView() {
        super.loadView()
        self.view = enteredRoomView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        enteredRoomView.friendsCollecionView.dataSource = self

        configure()
        setBinding()
        exportID()
        
        let tapArrive = UITapGestureRecognizer(target: self, action: #selector(pressArriveButton))
        enteredRoomView.arriveButton.isUserInteractionEnabled = true
        enteredRoomView.arriveButton.addGestureRecognizer(tapArrive)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enteredRoomViewModel.reflectStatus(roomName)
        moveToDestination()
    }
    
    func configure() {
        enteredRoomView.placeInputLabel.text = placeName
        enteredRoomView.moneyInputLabel.text = String(money)
    }
    
    func moveToDestination() {
        let latitude = placeCoordinate[0]
        let longitude = placeCoordinate[1]
        let zoomCamera = GMSCameraUpdate.zoomIn()
        enteredRoomView.mapView.animate(with: zoomCamera)
        let destination = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let marker = GMSMarker(position: destination)
        marker.icon = UIImage(named: "custom_pin.png")
        marker.icon = GMSMarker.markerImage(with: .systemPink)
        marker.map = enteredRoomView.mapView
        
        let circle = GMSCircle(position: destination, radius: 50)
        circle.fillColor = UIColor(red: 33/255, green: 146/255, blue: 255/255, alpha: 0.5)
        circle.strokeWidth = 0
        circle.map = enteredRoomView.mapView
        
        let newCamera = GMSCameraUpdate.setTarget(destination)
        enteredRoomView.mapView.moveCamera(newCamera)
    }
    
    func exportID() {
        if let friends = friends {
            for friend in friends {
                ids.append((friend["id"] ?? "") ?? "")
            }
        }
    }
    
    @objc func pressArriveButton() {
        if enteredRoomViewModel.checkArrive(ids, placeCoordinate, roomName, notificationKey) {
            enteredRoomView.arriveButton.isEnabled = false
            enteredRoomView.arriveButton.backgroundColor = .systemGray
            enteredRoomView.arriveStatusImageView.image = UIImage(systemName: "checkmark.circle")
            enteredRoomView.arriveStatusImageView.tintColor = .systemGreen
        } else {
            enteredRoomView.arriveStatusImageView.image = UIImage(systemName: "xmark.circle")
            enteredRoomView.arriveStatusImageView.tintColor = .systemRed
        }
    }
}

extension EnteredRoomViewController {
    private func setBinding() {
        self.enteredRoomViewModel.$friendsStatus.sink { [weak self] updatedStatusList in
            self?.friendsStatus = updatedStatusList
            DispatchQueue.main.async {
                self?.enteredRoomView.friendsCollecionView.reloadData()
                let status = self?.enteredRoomViewModel.reflectMyStatus()
                if status == true {
                    self?.enteredRoomView.arriveButton.isEnabled = false
                    self?.enteredRoomView.arriveButton.backgroundColor = .systemGray
                    self?.enteredRoomView.arriveStatusImageView.image = UIImage(systemName: "checkmark.circle")
                    self?.enteredRoomView.arriveStatusImageView.tintColor = .systemGreen
                }
            }
        }.store(in: &disposalbleBag)
    }
}

extension EnteredRoomViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friends?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EnteredRoomFriendsCollectionViewCell.identifier, for: indexPath) as? EnteredRoomFriendsCollectionViewCell else {return UICollectionViewCell()}
        cell.nickNameLabel.text = friends?[indexPath.item]["nickName"] ?? ""
        cell.nickNameLabel.textColor = checkStatus(indexPath.item, cell) ? .systemGreen : .black
        // 여기서 직접 요청해야할듯..?
        return cell
    }
    
    func checkStatus(_ index : Int, _ cell : EnteredRoomFriendsCollectionViewCell) -> Bool {
        let id = friends?[index]["id"]
        if let friendsStatus = friendsStatus {
            for friend in friendsStatus {
                if id == friend.id {
                    return friend.status
                }
            }
        }
        return false
    }
}

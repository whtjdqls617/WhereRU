//
//  EnteredRoomViewController.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/25.
//

import UIKit
import KakaoSDKFriend
import Combine

class EnteredRoomViewController: BaseViewController {
    
    var friends : [[String : String?]]?
    var ids : [String] = []
    var placeName : String = ""
    var placeCoordinate = [Double]()
    var money : Int = 0
    var roomName : String = ""
        
    var friendsStatus : [FriendInRoom]?
    private var disposalbleBag = Set<AnyCancellable>()
    
    let enteredRoomView = EnteredRoomView()
    let enteredRoomViewModel = EnteredRoomViewModel()
    
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
    }
    
    func configure() {
        enteredRoomView.placeInputLabel.text = placeName
        enteredRoomView.moneyInputLabel.text = String(money)
    }
    
    func exportID() {
        if let friends = friends {
            for friend in friends {
                ids.append((friend["id"] ?? "") ?? "")
            }
        }
    }
    
    @objc func pressArriveButton() {
        if enteredRoomViewModel.checkArrive(ids, placeCoordinate, roomName) {
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
                if ((self?.enteredRoomViewModel.reflectMyStatus()) != nil) {
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

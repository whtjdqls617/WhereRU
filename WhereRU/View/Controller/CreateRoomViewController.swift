//
//  CreateRoomViewController.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/02.
//

import UIKit
import Combine
import KakaoSDKFriend

class CreateRoomViewController: BaseViewController {
        
    private let createRoomView = CreateRoomView()
    private let createRoomViewModel = CreateRoomViewModel()
    
    var selectedFriends : SelectedUsers?
    var latitude : Double = 0
    var longitude : Double = 0
    private var disposalbleBag = Set<AnyCancellable>()

    override func loadView() {
        super.loadView()
        self.view = createRoomView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createRoomView.friendsCollecionView.dataSource = self
        
        setBinding()
        navigationItem.title = "방 만들기"
        
        let tapAdd = UITapGestureRecognizer(target: self, action: #selector(pressPlusButton))
        createRoomView.addFriendsButton.isUserInteractionEnabled = true
        createRoomView.addFriendsButton.addGestureRecognizer(tapAdd)
        
        let tapPlace = UITapGestureRecognizer(target: self, action: #selector(pressFindPlaceButton))
        createRoomView.placeInputLabel.isUserInteractionEnabled = true
        createRoomView.placeInputLabel.addGestureRecognizer(tapPlace)
        
        let tapMoney = UITapGestureRecognizer(target: self, action: #selector(pressCreateButton))
        createRoomView.createButton.isUserInteractionEnabled = true
        createRoomView.createButton.addGestureRecognizer(tapMoney)
        
        let tapCreate = UITapGestureRecognizer(target: self, action: #selector(pressCreateButton))
        createRoomView.createButton.isUserInteractionEnabled = true
        createRoomView.createButton.addGestureRecognizer(tapCreate)
        
        let tapCancle = UITapGestureRecognizer(target: self, action: #selector(pressCancleButton))
        createRoomView.cancleButton.isUserInteractionEnabled = true
        createRoomView.cancleButton.addGestureRecognizer(tapCancle)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func pressPlusButton() {
        createRoomViewModel.getSelectedFriendsListFromKakao()
    }
    
    @objc func pressFindPlaceButton() {
        let findPlaceVC = FindPlaceViewController()
        findPlaceVC.delegate = self
        navigationController?.pushViewController(findPlaceVC, animated: true)
    }
    
    @objc func pressCreateButton() {
        let name = String().makeRandomString()
        let locationName = createRoomView.placeInputLabel.text
        let location = ["name" : locationName as Any, "coordinate" : [latitude, longitude]] as [String : Any]
        guard let money = Int(createRoomView.moneyInputTextField.text ?? "") else {return}
        guard let friends = selectedFriends else {return}
        let limitTime = "6:00"
        createRoomViewModel.updateRoomsList(name, location, money, friends, limitTime)
        // http post 요청을 해야한다. (각각의 토큰 알아야함, 방이름)
        dismiss(animated: true)
    }
    
    @objc func pressCancleButton() {
        dismiss(animated: true)
    }
}

extension CreateRoomViewController {
    private func setBinding() {
        self.createRoomViewModel.$selectedFriendsList.sink { [weak self] updatedFriendsList in
            self?.selectedFriends = updatedFriendsList
            DispatchQueue.main.async {
                self?.createRoomView.friendsCollecionView.reloadData()
            }
        }.store(in: &disposalbleBag)
    }
}

extension CreateRoomViewController: SelectLocationDelegate {
    func sendInfoToCreateRoom(_ destination: String?, _ latitude: Double, _ longitude: Double) {
        if let destination = destination {
            print(destination)
            createRoomView.placeInputLabel.text = destination
            self.latitude = latitude
            self.longitude = longitude
        } else {
            createRoomView.placeInputLabel.text = "선택"
            createRoomView.placeInputLabel.textColor = .systemBlue
        }
    }
}

extension CreateRoomViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedFriends?.totalCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddedFriendsCollectionViewCell.identifier, for: indexPath) as? AddedFriendsCollectionViewCell else {return UICollectionViewCell()}
        cell.nickNameLabel.text = selectedFriends?.users?[indexPath.item].profileNickname
        return cell
    }
}

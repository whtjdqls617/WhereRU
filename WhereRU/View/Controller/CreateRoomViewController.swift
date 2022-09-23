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
        
        let button = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(pressPlusButton))
        navigationItem.rightBarButtonItem = button
        navigationItem.title = "친구 추가"
                
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
        // 방 생성 (방이름, 장소, 인원, 시간, 돈)
        
        // 내 방목록 업데이트
        
        // 상대방들 방목록 업데이트
        
        // 방이름
        // 장소 (위도, 경도)
        // 인원 (id, 닉네임, 프로필사진)
        // 시간
        // 돈
        
        let name = String().makeRandomString()
        let locationName = createRoomView.placeLabel.text
        let location = ["name" : locationName as Any, "coordinate" : [latitude, longitude]] as [String : Any]
        guard let money = Int(createRoomView.moneyInputTextField.text ?? "") else {return}
        guard let friends = selectedFriends else {return}
        let limitTime = "6:00"
        createRoomViewModel.updateRoomsList(name, location, money, friends, limitTime)
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
    func getPlaceInfo(_ destination : String?, _ latitude : Double, _ longitude : Double) {
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

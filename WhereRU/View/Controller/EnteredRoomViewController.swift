//
//  EnteredRoomViewController.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/25.
//

import UIKit
import KakaoSDKFriend

class EnteredRoomViewController: BaseViewController {
    
    var frineds : [[String : String?]]?
    var placeName : String = ""
    var placeCoordinate = [Double]()
    var money : Int = 0
    
    let enteredRoomView = EnteredRoomView()
    
    override func loadView() {
        super.loadView()
        self.view = enteredRoomView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        enteredRoomView.friendsCollecionView.dataSource = self

        configure()
        
        let tapArrive = UITapGestureRecognizer(target: self, action: #selector(pressArriveButton))
        enteredRoomView.arriveButton.isUserInteractionEnabled = true
        enteredRoomView.arriveButton.addGestureRecognizer(tapArrive)
    }
    
    func configure() {
        enteredRoomView.placeInputLabel.text = placeName
        enteredRoomView.moneyInputLabel.text = String(money)
    }
    
    @objc func pressArriveButton() {
        
    }
}

extension EnteredRoomViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frineds?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EnteredRoomFriendsCollectionViewCell.identifier, for: indexPath) as? EnteredRoomFriendsCollectionViewCell else {return UICollectionViewCell()}
        cell.nickNameLabel.text = frineds?[indexPath.item]["nick name"] ?? ""
        
        return cell
    }
}

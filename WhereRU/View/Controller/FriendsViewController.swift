//
//  FriendsViewController.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/08/31.
//

import UIKit
import Combine
import KakaoSDKTalk
import KakaoSDKUser

class FriendsViewController: BaseViewController {
    
    let friendsView = FriendsView()
    let friendsViewModel = FriendsViewModel()
    
    var friendsList : FriendsList?
    private var disposalbleBag = Set<AnyCancellable>()

    override func loadView() {
        super.loadView()
        self.view = friendsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsView.friendTableView.dataSource = self
        
        setBinding()
        friendsViewModel.getFriendsListFromKakao()
        friendsViewModel.saveMyIdFromKakao()
        
//        disconnectAccount()
    }
    
    func disconnectAccount() {
        UserApi.shared.unlink {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("unlink() success.")
            }
        }
    }
}

extension FriendsViewController {
    private func setBinding() {
        self.friendsViewModel.$friendsList.sink { [weak self] updatedFriendsList in
            self?.friendsList = updatedFriendsList
            DispatchQueue.main.async {
                self?.friendsView.friendTableView.reloadData()
            }
        }.store(in: &disposalbleBag)
    }
}

extension FriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsList?.totalCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.identifier, for: indexPath) as? FriendsTableViewCell else {return UITableViewCell()}
        cell.nickNameLabel.text = friendsList?.elements[indexPath.row].profileNickname
        return cell
    }
}

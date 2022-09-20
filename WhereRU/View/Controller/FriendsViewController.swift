//
//  FriendsViewController.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/08/31.
//

import UIKit
import KakaoSDKTalk
import KakaoSDKUser

class FriendsViewController: BaseViewController {
    
    var friendsList : FriendsList?
    
    let friendsView = FriendsView()
    let friendsViewModel = FriendsViewModel()

    override func loadView() {
        super.loadView()
        self.view = friendsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsView.friendTableView.dataSource = self
        
        friendsViewModel.kakaoManager.getFriendsListFromKakao { list in
            if let list = list {
                self.friendsList = list
                print(self.friendsList)
                DispatchQueue.main.async {
                    self.friendsView.friendTableView.reloadData()
                }
            }
        }
//        getFriendsListFromFirebase()
//        disconnectAccount()
    }

    func getFriendsListFromFirebase() {
        TalkApi.shared.friends { friends, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print(friends?.elements)
            }
        }
    }
    
    func parseJSON() {
        
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

extension FriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(friendsList?.totalCount)
        return friendsList?.totalCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.identifier, for: indexPath) as? FriendsTableViewCell else {return UITableViewCell()}
        cell.nickNameLabel.text = friendsList?.elements[0].profileNickname
        return cell
    }
}

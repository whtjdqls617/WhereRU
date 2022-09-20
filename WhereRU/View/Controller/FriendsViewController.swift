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
    
//    var friendsList = Friends[]
    
    let friendsView = FriendsView()

    override func loadView() {
        super.loadView()
        self.view = friendsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFriendsListFromFirebase()
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.identifier, for: indexPath)
        return cell
    }
}

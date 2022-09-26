//
//  FriendsViewModel.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/20.
//

import Foundation

class FriendsViewModel {
    
    @Published var friendsList : FriendsList?
    
    let kakaoManager = KakaoManager()
    
    func saveMyIdFromKakao() {
        kakaoManager.saveMyId()
    }
    
    func getFriendsListFromKakao() {
        kakaoManager.getFriendsListFromKakao { list in
            if let list = list {
                self.friendsList = list
            }
        }
    }
}

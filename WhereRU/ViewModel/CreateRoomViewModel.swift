//
//  CreateRoomViewModel.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/22.
//

import Foundation
import KakaoSDKFriend

class CreateRoomViewModel {
    
    @Published var selectedFriendsList : SelectedUsers?
    
    let kakaoManager = KakaoManager()
    
    func getSelectedFriendsListFromKakao() {
        kakaoManager.getSelectedFriendsListFromKakao { list in
            if let list = list {
                self.selectedFriendsList = list
            }
        }
    }
}

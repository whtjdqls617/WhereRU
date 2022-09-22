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
    var emailList = [String]()
    
    let kakaoManager = KakaoManager()
    let firebaseManager = FirebaseManager()
    
    func getSelectedFriendsListFromKakao() {
        kakaoManager.getSelectedFriendsListFromKakao { list in
            if let list = list {
                self.selectedFriendsList = list
            }
        }
    }
    
    func updateRoomsList(_ name : String, _ location : [Double], _ money : Int, _ friends : SelectedUsers, _ limitTime : String) {
        firebaseManager.updateRoomsOfFirestore(name, location, money, friends, limitTime)
    }
}

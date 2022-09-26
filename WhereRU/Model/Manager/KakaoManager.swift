//
//  KakaoManager.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/20.
//

import Foundation
import KakaoSDKTalk
import KakaoSDKFriend
import KakaoSDKUser

class KakaoManager {
    
    func saveMyId() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                UserDefaults.standard.set(user?.id, forKey: "id")
            }
        }
    }
    
    func getFriendsListFromKakao(completion: @escaping (FriendsList?) -> Void) {
        TalkApi.shared.friends { friends, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let friends = friends {
                let result = self.parseJSON(friends)
                completion(result)
            }
        }
    }
    
    func getSelectedFriendsListFromKakao(completion: @escaping (SelectedUsers?) -> Void) {
        let openPickerFriendRequestParams = OpenPickerFriendRequestParams(
            showMyProfile: true
        )
        
        PickerApi.shared.selectFriends(params: openPickerFriendRequestParams) { selectedUsers, error in
            if let error = error {
                print(error.localizedDescription)
            }
            else if let friends = selectedUsers {
                completion(friends)
            }
        }
    }
    
    func parseJSON(_ data: Friends<KakaoSDKTalk.Friend>) -> FriendsList? {
        guard let elements : [KakaoSDKTalk.Friend] = data.elements else {return nil}
        let totalCount = data.totalCount
        
        return(FriendsList(elements: elements, totalCount: totalCount))
    }
}

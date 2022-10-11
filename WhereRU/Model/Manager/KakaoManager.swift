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
    
    let firebaseManager = FirebaseManager()
    
    func saveMyId() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                UserDefaults.standard.set(user?.id, forKey: "id")
                UserDefaults.standard.set("AAAArVqJom8:APA91bG-Trol-FRvIPVnIqVzUWgczMtK_EcOS716-PuyYiz9U7339qRG5N7l6pC_r13wgUFSvtRV9o9YFUgcxemOiUsI5f187zVnE0GzAWThN7VIDkkDU6jsMMPqh9b9zotmVdrUHoJQ", forKey: "serverKey")
                UserDefaults.standard.set("744548311663", forKey: "projectID")
                UserDefaults.standard.set(user?.kakaoAccount?.profile?.nickname, forKey: "nickName")
                let id = String(user?.id ?? 0)
                self.saveMyToken(id)
            }
        }
    }
    
    func saveMyToken(_ id : String) {
        let token = UserDefaults.standard.string(forKey: "token")
        firebaseManager.setFCMToken(token, id)
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

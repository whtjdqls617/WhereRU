//
//  FirebaseManager.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/14.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import KakaoSDKFriend
import KakaoSDKUser

class FirebaseManager {
    
    let db = Firestore.firestore()
    
    func uploadDataToFirestore(_ email : String, _ nickName : String, _ id : Int64) {
        
        db.collection("Users").document(String(id)).setData(["email" : email, "nickName" : nickName], merge: true) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Success!")
            }
        }
    }
    
    func updateStatus(_ ids : [String], _ roomName : String) {
        // 속해있는 인원 전부의 그 방 도착한 애 상태를 바꿔야함
        let requestId = UserDefaults.standard.string(forKey: "id") ?? ""
        for id in ids {
            db.collection("Users").document(id).collection("Rooms").document(roomName).collection("Friends").document(requestId).updateData(["status" : true])
        }
    }
    
    func updateRoomsOfFirestore(_ name : String, _ location : [String : Any], _ money : Int, _ friends : SelectedUsers, _ limitTime : String) {
        guard let guardFriends = friends.users else {return}
        var friendsTmp = [[String : String?]]()
        for friend in guardFriends {
            let profileString = friend.profileThumbnailImage?.absoluteString
            let nickName = friend.profileNickname ?? ""
            let id : String = String(friend.id ?? 0)
            let tmp = ["nickName" : nickName, "profile" : profileString, "id" : id]
            friendsTmp.append(tmp)
        }
        for user in guardFriends {
            db.collection("Users").document(String(user.id ?? 0)).collection("Rooms").document(name).setData(["location" : location, "money" : money, "name" : name, "friends" : friendsTmp])
            for friend in guardFriends {
                db.collection("Users").document(String(user.id ?? 0)).collection("Rooms").document(name).collection("Friends").document(String(friend.id ?? 0)).setData(["id" : String(user.id ?? 0), "status" : false])
            }
        }
    }
    
    func getRoomsListFromFirestore(completion: @escaping ([Room]?) -> Void) {
        guard let id = UserDefaults.standard.string(forKey: "id") else {return}
        let docRef = db.collection("Users").document(id).collection("Rooms")
        docRef.getDocuments { collection, error in
            if error != nil {
                print("방이 존재하지 않습니다.")
            } else if let collection = collection {
                print(collection.documents)
                let result = self.roomParseJSON(collection.documents)
                completion(result)
            }
        }
    }
    
    func roomParseJSON(_ documents : [QueryDocumentSnapshot]) -> [Room]? {
        do {
            var tmp : [Room] = []
            for document in documents {
                let data = document.data()
                let JSONData = try JSONSerialization.data(withJSONObject: data, options: [])
                let ret = try JSONDecoder().decode(Room.self, from: JSONData)
                tmp.append(ret)
            }
            return tmp
         }
         catch {
           print(error)
         }
        return nil
    }
    
    func getUsersStatus(_ roomName : String, completion: @escaping ([FriendInRoom]?) -> Void) {
        guard let id = UserDefaults.standard.string(forKey: "id") else {return}
        db.collection("Users").document(id).collection("Rooms").document(roomName).collection("Friends").getDocuments { collection, error in
            if error != nil {
                print("error")
            } else if let collection = collection {
                let result = self.friendParseJSON(collection.documents)
                completion(result)
            }
        }
    }
    
    func friendParseJSON(_ documents : [QueryDocumentSnapshot]) -> [FriendInRoom]? {
        do {
            var tmp : [FriendInRoom] = []
            for document in documents {
                let data = document.data()
                let JSONData = try JSONSerialization.data(withJSONObject: data, options: [])
                let ret = try JSONDecoder().decode(FriendInRoom.self, from: JSONData)
                tmp.append(ret)                
            }
            return tmp
        }
        catch {
            print(error)
        }
        return nil
    }
    
    func setFCMToken(_ token: String?, _ id : String) {
        if let token = token {
            db.collection("Users").document(id).updateData(["token" : token])
        }
    }
    
}

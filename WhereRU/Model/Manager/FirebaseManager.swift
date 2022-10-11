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
    
    func getNickName(_ friends: [SelectedUser], completion: @escaping ([[String : String?]]) -> Void) {
        var friendsTmp = [[String : String?]]()
        for friend in friends {
            let profileString = friend.profileThumbnailImage?.absoluteString
//            let nickName = friend.profileNickname ?? ""
            // 닉네임을 firebase에 있는 nickname으로 변경해야함
            let id : String = String(friend.id ?? 0)
            
            db.collection("Users").document(id).getDocument { document, error in
                if error != nil {
                    print("error")
                } else {
                    if let document = document {
//                        print(data?["nickName"])
                        let nickName = self.parseUser(document)?.nickName
                        let tmp = ["nickName" : nickName, "profile" : profileString, "id" : id]
                        friendsTmp.append(tmp)
                        if friendsTmp.count == friends.count {
                            completion(friendsTmp)                            
                        }
                    }
                }
            }
        }
    }
    
    func updateRoomsOfFirestore(_ name : String, _ location : [String : Any], _ money : Int, _ friends : SelectedUsers, _ limitTime : String) {
        guard let guardFriends = friends.users else {return}
        getNickName(guardFriends) { friends in
            print(friends)
            for user in guardFriends {
                self.db.collection("Users").document(String(user.id ?? 0)).collection("Rooms").document(name).setData(["location" : location, "money" : money, "name" : name, "friends" : friends])
                for friend in guardFriends {
                    self.db.collection("Users").document(String(user.id ?? 0)).collection("Rooms").document(name).collection("Friends").document(String(friend.id ?? 0)).setData(["id" : String(friend.id ?? 0), "status" : false])
                }
            }
        }
    }
    
    func parseUser(_ document : DocumentSnapshot?) -> User? {
        var tmp : User?
        do {
            guard let data = document?.data() else {return nil}
            let JSONData = try JSONSerialization.data(withJSONObject: data, options: [])
            let ret = try JSONDecoder().decode(User.self, from: JSONData)
            print(ret)
            tmp = ret
        } catch {
            print("error")
        }
        return tmp
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
    
    func createGroupInFCMByHttp(_ roomName : String, _ friends : SelectedUsers) {
        // friends의 id들을 알고 있음 이것들을 이용해서 각각의 토큰 값들을 얻어옴
        guard let guardFriends = friends.users else {return}
        var friendsIdTmp = [String]()
        for friend in guardFriends {
            let id : String = String(friend.id ?? 0)
            friendsIdTmp.append(id)
        }
        
        var tokens = [String?]()
        for id in friendsIdTmp {
            db.collection("Users").document(id).getDocument { document, error in
                if error != nil {
                    print("error")
                } else if let document = document {
                    let data = document.data()
                    print("data : ", type(of: data?["token"]))
                    let token = self.parseUser(document)?.token
                    // 여기서 토큰들을 하나씩 추가하고 외부에서 다 모은 토큰값들을 가지고 request해야 할 것 같은데, 추가하는 배열이 다 채워져야 할 수 있으므로 크게 dispatchgroup으로 묶어서 비동기 제어 해야 할 것 같음
                    tokens.append(token)
                    if tokens.count == friendsIdTmp.count {
                        self.postCreateRoomToFCM(roomName, tokens, friendsIdTmp)
                    }
                }
            }
        }
    }
    
    func postCreateRoomToFCM(_ roomName : String, _ tokens: [String?], _ ids : [String]) {
        guard let url = URL(string: "https://fcm.googleapis.com/fcm/notification") else {return}
        
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        // header
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let serverKey = UserDefaults.standard.string(forKey: "serverKey") ?? ""
        let projectID = UserDefaults.standard.string(forKey: "projectID") ?? ""
        request.addValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
        request.addValue(projectID, forHTTPHeaderField: "project_id")
        // body
        let operation = "create"
        let tokens = tokens.compactMap {$0}
        let body = ["operation" : operation, "notification_key_name" : roomName, "registration_ids" : tokens] as [String : Any]
        let bodyData = try? JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = bodyData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            let successRange = 200..<300
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, successRange.contains(statusCode) else {return}
            if let data = data {
                print(data)
                // 여기서 방의 notification key 저장
                
                DispatchQueue.main.async {
                    do{
                        guard let object = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {return}
                        let notificationKey = object["notification_key"]
                        for id in ids {
                            self.db.collection("Users").document(id).collection("Rooms").document(roomName).setData(["notificationKey" : notificationKey as Any], merge: true)
                        }
                    } catch{
                        print("error")
                    }
                    
                }
            }
        }
        task.resume()
    }
    
    func postCreateRoomToFCM(_ notificationKey : String) {
        guard let url = URL(string: "https://fcm.googleapis.com/fcm/send") else {return}
        
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        // header
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let serverKey = UserDefaults.standard.string(forKey: "serverKey") ?? ""
        request.addValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
        // body
        let nickName = UserDefaults.standard.string(forKey: "nickName") ?? ""
        let body = ["to" : notificationKey,
                    "notification" : ["title" : "도착 알림", "body" : "\(nickName)님이 도착하셨습니다!"]] as [String : Any]
        let bodyData = try? JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = bodyData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            let successRange = 200..<300
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, successRange.contains(statusCode) else {return}
            if let data = data {
                print(data)
                // 여기서 방의 notification key 저장
                
                DispatchQueue.main.async {
                    do{
                        guard let object = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {return}
                        print("result : ", object["success"])
                    } catch{
                        print("error")
                    }
                    
                }
            }
        }
        task.resume()
    }
}

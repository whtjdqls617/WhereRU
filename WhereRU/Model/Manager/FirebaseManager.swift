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
    
//    func getRoomsFromAllUsers(_ id : String, completion: @escaping ([Room]?) -> Void) {
//        let docRef = self.db.collection("Users").document(id)
//        docRef.getDocument { document, error in
//            if error != nil {
//                print("방이 존재하지 않습니다.")
//            } else if let document = document, document.exists {
//                guard let data = document.data() else {return}
//                let tmp = self.parseJSON(data)
//                completion(tmp)
//            }
//        }
//    }
    
    func checkVaildEmailFromFirestore(_ email : String, completion: @escaping (Bool) -> Void) {
        if email.contains("@") == false {
            return
        }
        let documentName = makeDocumentName(email)
        
        let docRef = db.collection("Users").document(documentName)
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                print("exist")
                completion(false)
            } else {
                print("not exist")
                completion(true)
            }
        }
    }
    
    func makeDocumentName(_ email : String) -> String {
        let id = email.components(separatedBy: "@")[0]
        let mail = email.components(separatedBy: "@")[1]
        let documentName = id + "_" + mail
        return documentName
    }
    
    enum SearchStatus {
        case success
        case notSearch
        case failure
    }
    
    func getDocumentFromFirestore(_ email : String, completion: @escaping (SearchStatus, DocumentSnapshot?) -> Void) {
        if email.contains("@") == false {
            return
        }
        let docName = makeDocumentName(email)
        let docRef = db.collection("Users").document(docName)
        
        docRef.getDocument { document, error in
            if error != nil {
                print("사용자가 존재하지 않습니다.")
                completion(.failure, nil)
            } else if let document = document, document.exists {
                completion(.success, document)
            } else {
                completion(.notSearch, nil)
            }
        }
    }
    
    func addFriendToFirestore(_ email : String, _ nickName : String) {
        let currentUserEmail = Auth.auth().currentUser?.email ?? ""
        
        let docName = makeDocumentName(currentUserEmail)
        db.collection("Users").document(docName).setData(["friends" : [email : nickName]], merge: true)
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
    
    func getUserStatus(_ id : String, _ roomName : String, completion: @escaping (FriendInRoom?) -> Void) {
        db.collection("Users").document(id).collection("Rooms").document(roomName).collection("Friends").document(id).getDocument { document, error in
            if error != nil {
                print("error")
            } else if let document = document {
                let result = self.statusParseJSON(document)
                completion(result)
            }
        }
    }
    
    func statusParseJSON(_ document : DocumentSnapshot) -> FriendInRoom? {
        do {
            var tmp : FriendInRoom?
            guard let data = document.data() else {return nil}
            let JSONData = try JSONSerialization.data(withJSONObject: data)
            let ret = try JSONDecoder().decode(FriendInRoom.self, from: JSONData)
            tmp = ret
            return tmp
        }
        catch {
            print(error)
        }
        return nil
    }
}

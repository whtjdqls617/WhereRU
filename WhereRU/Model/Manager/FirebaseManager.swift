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
    
//    func updateStatus(_ idOfFriends : [String?], _ roomName : String) {
//        // 속해있는 인원 전부의 그 방 도착한 애 상태를 바꿔야함
//        let ids = idOfFriends.compactMap {$0}
//        for id in ids {
//            getRoomsFromAllUsers(id) { roomList in
//                if let roomList = roomList {
//                    for i in roomList.indices {
//                        if roomList[i].name == roomName {
//                            self.updateRoomsOfFirestore(i, id, roomName, roomList[i].location, roomList[i].money, roomList[i].friends, "")
//                            print("here")
//                        }
//                    }
//                }
//            }
//        }
//    }
    
    func getRoomsFromAllUsers(_ id : String, completion: @escaping ([Room]?) -> Void) {
        let docRef = self.db.collection("Users").document(id)
        docRef.getDocument { document, error in
            if error != nil {
                print("방이 존재하지 않습니다.")
            } else if let document = document, document.exists {
                guard let data = document.data() else {return}
                let tmp = self.parseJSON(data)
                completion(tmp)
            }
        }
    }
    
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
        var temp = [[String : Any]]()
        guard let guardFriends = friends.users else {return}
        temp = guardFriends.compactMap{["profile" : $0.profileThumbnailImage as Any, "nick name" : $0.profileNickname as Any, "id" : String($0.id ?? 0) as Any, "status" : "false"]}
        let docData: [String:Any] = [
            "name" : name,
            "money" : money,
            "location" : location,
            "friends" : temp,
        ]
        for user in guardFriends {
            db.collection("Users").document(String(user.id ?? 0)).updateData(["rooms" : FieldValue.arrayUnion([docData])])
        }
    }
    
//    func updateRoomsOfFirestore(_ i : Int, _ id : String, _ name : String, _ location : Location, _ money : Int, _ friends : [[String : String?]], _ limitTime : String) {
//        var temp = [[String : Any]]()
//        var status = "false"
//        if id == UserDefaults.standard.string(forKey: "id") {
//            status = "true"
//        }
//        var location2 : [String : Any]?
//        location2?["coordinate"] = location.coordinate
//        location2?["name"] = location.name
//        temp = friends.compactMap{["profile" : $0["profile"] as Any, "nick name" : $0["nick name"] as Any, "id" : $0["id"] as Any, "status" : status]}
//        let docData: [String:Any] = [
//            "name" : name,
//            "money" : money,
//            "location" : location2 as Any,
//            "friends" : temp,
//        ]
//
//        let batch = db.batch()
//        batch.updateData(["rooms" : "hi"], forDocument: db.collection("Users").document(id))
//    }
    
    func getRoomsListFromFirestore(completion: @escaping ([Room]?) -> Void) {
        // 내 id가지고 진행해야 함
        // 개인 id를 그냥 로컬에 가지고 있으면 편할 것 같음
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                let docRef = self.db.collection("Users").document(String(user?.id ?? 0))
                docRef.getDocument { document, error in
                    if error != nil {
                        print("방이 존재하지 않습니다.")
                    } else if let document = document, document.exists {
                        guard let data = document.data() else {return}
                        let tmp = self.parseJSON(data)
                        completion(tmp)
                    }
                }
                
                
            }
        }
    }
    
    func parseJSON(_ data : [String : Any]) -> [Room]? {
        do {
            var tmp : User
            let data = try JSONSerialization.data(withJSONObject: data, options: [])
            tmp = try JSONDecoder().decode(User.self, from: data)
            
            
            print("room : ", tmp.rooms)
            return tmp.rooms
         }
         catch {
           print(error)
         }
        return nil
    }
}

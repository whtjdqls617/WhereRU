//
//  FirebaseManager.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/14.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FirebaseManager {
    
    let db = Firestore.firestore()

    func uploadDataToFirestore(_ email : String, _ name : String) {
        let totalId = makeDocumentName(email)
        
        db.collection("Users").document(totalId).setData(["email" : email, "name" : name]) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Success!")
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
}

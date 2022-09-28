//
//  EnteredRoomViewModel.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/26.
//

import Foundation
import CoreLocation

class EnteredRoomViewModel {
    
    let locationManager = CLLocationManager()
    var currentLocation : CLLocationCoordinate2D?
    let firebaseManager = FirebaseManager()
    
    @Published var friendsStatus : [FriendInRoom]?
    
    func checkArrive(_ ids : [String], _ destination : [Double], _ roomName : String) -> Bool {
        currentLocation = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0)
        let destination = CLLocationCoordinate2D(latitude: destination[0], longitude: destination[1])
        let distance = Int(destination.distance(from: currentLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)))
        if distance < 50 {
            // 파이어베이스 에서 status = true로 바꾸기
            changeUserStatusOfFirestore(ids, roomName)
            return true
        } else {
            return false
        }
    }
    
    func changeUserStatusOfFirestore(_ ids : [String], _ roomName : String) {
        // 유저를 먼저 다 돌면서 도착한 유저의 status를 바꾼다.
        firebaseManager.updateStatus(ids, roomName)
    }
    
    func reflectStatus(_ roomName : String) {
        firebaseManager.getUsersStatus(roomName) { friendsStatus in
            self.friendsStatus = friendsStatus
        }
    }
    
    func reflectMyStatus() -> Bool {
        if let friendsStatus = friendsStatus {
            let id = UserDefaults.standard.string(forKey: "id")
            for friend in friendsStatus {
                if friend.id == id {
                    return friend.status
                }
            }
        }
        return false
    }
}

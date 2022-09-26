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
    
    func checkArrive(_ destination : [Double], _ friends : [[String : String?]]?, _ roomName : String) -> Bool {
        currentLocation = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0)
        let destination = CLLocationCoordinate2D(latitude: destination[0], longitude: destination[1])
        let distance = Int(destination.distance(from: currentLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)))
        if distance < 50 {
            // 파이어베이스 에서 status = true로 바꾸기
            changeUserStatusOfFirestore(friends, roomName)
            return true
        } else {
            return false
        }
    }
    
    func changeUserStatusOfFirestore(_ friends : [[String : String?]]?, _ roomName : String) {
        // 유저를 먼저 다 돌면서 도착한 유저의 status를 바꾼다.
        guard let friends = friends else {
            return
        }
        let idOfFriends = friends.compactMap {$0["id"]}
//        firebaseManager.updateStatus(idOfFriends, roomName)
    }
}

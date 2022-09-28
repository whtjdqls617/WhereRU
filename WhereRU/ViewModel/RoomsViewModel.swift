//
//  RoomsViewModel.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/02.
//

import Foundation
import CoreLocation

class RoomsViewModel {
    
    @Published var roomsList : [Room]?
    @Published var friendsInRoomList : [[FriendInRoom]]?
    
    let firebaseManager = FirebaseManager()
    
    func getRoomdDataFromFirestore() {
        firebaseManager.getRoomsListFromFirestore() { data in
            self.roomsList = data
        }
    }
}

//
//  Rooms.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/24.
//

import Foundation

struct Room : Codable {
    let friends : [[String : String?]]
    let location : Location
    let money : Int
    let name : String
//    let timestamp : String
}

struct Location : Codable {
    let coordinate : [Double]
    let name : String
}

struct FriendInRoom : Codable {
    let id : String
    let status : Bool
}

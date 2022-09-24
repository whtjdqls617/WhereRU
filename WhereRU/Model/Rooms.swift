//
//  Rooms.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/24.
//

import Foundation

struct RoomsList : Codable {
    var elements : [Room]
}

struct Room : Codable {
    let friends : [[String : String?]]
    let location : Location
    let money : Int
    let name : String
}

struct Location : Codable {
    let coordinate : [Double]
    let name : String
}

struct User : Codable {
    let email : String
    let nickName : String
    let rooms : [Room]
}

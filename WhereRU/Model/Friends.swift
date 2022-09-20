//
//  Friends.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/20.
//

import Foundation
import KakaoSDKTalk

struct FriendsList: Codable {
    let elements: [KakaoSDKTalk.Friend]
    let totalCount: Int

    enum CodingKeys: String, CodingKey {
        case elements
        case totalCount = "total_count"
    }
}

struct Friend: Codable {
    let profileNickname, profileThumbnailImage: String
    let allowedMsg: Bool
    let uuid: String

    enum CodingKeys: String, CodingKey {
        case profileNickname = "profile_nickname"
        case profileThumbnailImage = "profile_thumbnail_image"
        case allowedMsg = "allowed_msg"
        case uuid
    }
}

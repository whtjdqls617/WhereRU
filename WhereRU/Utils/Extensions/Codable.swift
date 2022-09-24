//
//  Codable.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/24.
//

import Foundation

extension Decodable {
    static func decode<T: Decodable>(dictionary: [String: Any]) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: [.fragmentsAllowed])
        return try JSONDecoder().decode(T.self, from: data)
    }
}

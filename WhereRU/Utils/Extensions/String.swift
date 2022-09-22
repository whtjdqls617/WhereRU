//
//  String.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/22.
//

import Foundation

extension String {
    func makeRandomString() -> String {
        let str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        var ret = ""
        
        for _ in 0..<12
        {
            let random = Int(arc4random_uniform(UInt32(str.count)))
            
            ret += String(str[str.index(str.startIndex, offsetBy: random)])
        }
        print(ret)
        return ret
    }
}

//
//  CLLocationCoordinate2D + extension.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/07.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    func distance(from: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: self.latitude, longitude: self.longitude)
        return from.distance(from: to)
    }
}

//
//  FindPlaceViewModel.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/04.
//

import Foundation
import MapKit

class FindPlaceViewModel {
    // MARK: - Properties
    private var searchCompleter = MKLocalSearchCompleter() /// 검색을 도와주는 변수
    private var searchResults = [MKLocalSearchCompletion]() /// 검색 결과를 담는 변수
}

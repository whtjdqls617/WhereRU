//
//  RoomsViewController.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/01.
//

import UIKit
import Combine

class RoomsViewController: BaseViewController {

    private let roomsView = RoomsView()
    private let roomsViewModel = RoomsViewModel()
    
//    var roomsList
    private var disposalbleBag = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        self.view = roomsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

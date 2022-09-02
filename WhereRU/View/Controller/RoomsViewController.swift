//
//  RoomsViewController.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/01.
//

import UIKit

class RoomsViewController: BaseViewController {

    private let roomsView = RoomsView()
    
    override func loadView() {
        super.loadView()
        self.view = roomsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

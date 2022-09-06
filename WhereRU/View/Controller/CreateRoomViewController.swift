//
//  CreateRoomViewController.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/02.
//

import UIKit

class CreateRoomViewController: BaseViewController {
    
    static let identifier : String = "createRoomViewController"
    
    private let createRoomView = CreateRoomView()

    override func loadView() {
        super.loadView()
        self.view = createRoomView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(pressFindPlaceButton))
        createRoomView.placeInputLabel.isUserInteractionEnabled = true
        createRoomView.placeInputLabel.addGestureRecognizer(tap)
    }
    
    @objc func pressFindPlaceButton() {
        let findPlaceVC = FindPlaceViewController()
        navigationController?.pushViewController(findPlaceVC, animated: true)
    }

}

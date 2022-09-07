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
        
//        createRoomView.placeInputLabel.dele
    }
    
    @objc func pressFindPlaceButton() {
        let findPlaceVC = FindPlaceViewController()
        findPlaceVC.delegate = self
        navigationController?.pushViewController(findPlaceVC, animated: true)
    }
}

extension CreateRoomViewController: SelectLocationDelegate {
    func updatePlaceLabel(_ destination: String?) {
        if let destination = destination {
            print(destination)
            createRoomView.placeInputLabel.text = destination
        } else {
            createRoomView.placeInputLabel.text = "선택"
            createRoomView.placeInputLabel.textColor = .systemBlue
        }
    }
}

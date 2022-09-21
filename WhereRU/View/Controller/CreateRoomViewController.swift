//
//  CreateRoomViewController.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/02.
//

import UIKit
import KakaoSDKFriend

class CreateRoomViewController: BaseViewController {
        
    private let createRoomView = CreateRoomView()

    override func loadView() {
        super.loadView()
        self.view = createRoomView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(pressPlusButton))
        navigationItem.rightBarButtonItem = button
        navigationItem.title = "친구 추가"
                
        let tapPlace = UITapGestureRecognizer(target: self, action: #selector(pressFindPlaceButton))
        createRoomView.placeInputLabel.isUserInteractionEnabled = true
        createRoomView.placeInputLabel.addGestureRecognizer(tapPlace)
        
        let tapMoney = UITapGestureRecognizer(target: self, action: #selector(pressCreateButton))
        createRoomView.createButton.isUserInteractionEnabled = true
        createRoomView.createButton.addGestureRecognizer(tapMoney)
        
        let tapCreate = UITapGestureRecognizer(target: self, action: #selector(pressCreateButton))
        createRoomView.createButton.isUserInteractionEnabled = true
        createRoomView.createButton.addGestureRecognizer(tapCreate)
        
        let tapCancle = UITapGestureRecognizer(target: self, action: #selector(pressCancleButton))
        createRoomView.cancleButton.isUserInteractionEnabled = true
        createRoomView.cancleButton.addGestureRecognizer(tapCancle)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func pressPlusButton() {
        let openPickerFriendRequestParams = OpenPickerFriendRequestParams()

        PickerApi.shared.selectFriend(params: openPickerFriendRequestParams) { selectUsers, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
            }
        }
    }
    
    @objc func pressFindPlaceButton() {
        let findPlaceVC = FindPlaceViewController()
        findPlaceVC.delegate = self
        navigationController?.pushViewController(findPlaceVC, animated: true)
    }
    
    @objc func pressCreateButton() {
        dismiss(animated: true)
    }
    
    @objc func pressCancleButton() {
        dismiss(animated: true)
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

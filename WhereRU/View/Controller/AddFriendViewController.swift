//
//  AddFriendViewController.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/15.
//

import UIKit

class AddFriendViewController: BaseViewController {
    
    let addFriendView = AddFriendView()
    let firebaseManager = FirebaseManager()
    
    override func loadView() {
        super.loadView()
        self.view = addFriendView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                
        let button = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(pressXButton))
        button.tintColor = .black
        navigationItem.leftBarButtonItem = button
        navigationItem.title = "친구 선택"
                
    }
    
    @objc func pressXButton() {
        dismiss(animated: true)
    }
    
    @objc func pressAddButton() {

        dismiss(animated: true)
    }
}

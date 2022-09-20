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
        
        addFriendView.searchTextField.delegate = self
        
        let button = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(pressXButton))
        button.tintColor = .black
        navigationItem.leftBarButtonItem = button
        navigationItem.title = "친구 추가"
        
        addFriendView.searchTextField.returnKeyType = .search
        
        let tapAddButton = UITapGestureRecognizer(target: self, action: #selector(pressAddButton))
        addFriendView.addButton.isUserInteractionEnabled = true
        addFriendView.addButton.addGestureRecognizer(tapAddButton)
    }
    
    @objc func pressXButton() {
        dismiss(animated: true)
    }
    
    @objc func pressAddButton() {
        let email = addFriendView.searchTextField.text ?? ""
        let nickName = addFriendView.nickNameLabel.text ?? ""
        firebaseManager.addFriendToFirestore(email, nickName)
        dismiss(animated: true)
    }
}

extension AddFriendViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let email = addFriendView.searchTextField.text ?? ""
        if textField == addFriendView.searchTextField {
            firebaseManager.getDocumentFromFirestore(email) {[weak self] status, data in
                switch status {
                case .success:
                    guard let data = data?.data() else {return}
                    print(data["friends"])
                    self?.addFriendView.nickNameLabel.text = data["nickName"] as? String
                    self?.addFriendView.addButton.isHidden = false
                case .notSearch:
                    self?.addFriendView.nickNameLabel.text = ""
                    self?.addFriendView.addButton.isHidden = true
                case .failure:
                    print("통신에 실패했습니다.")
                }
            }
        }
        return true
    }
}

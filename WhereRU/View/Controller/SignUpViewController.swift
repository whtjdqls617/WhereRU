//
//  SignUpViewController.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/08.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: BaseViewController {
    
    let signUpView = SignUpView()
    let firebaseManager = FirebaseManager()
    
    var validEmail : Bool = false
    
    override func loadView() {
        super.loadView()
        self.view = signUpView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        signUpView.emailCheckButton.addTarget(self, action: #selector(pressCheckEmailButton), for: .touchUpInside)

        signUpView.finishButton.addTarget(self, action: #selector(pressFinishButton), for: .touchUpInside)
    }
    
//    @objc func pressCheckEmailButton() {
//        firebaseManager.checkVaildEmailFromFirestore(signUpView.emailTextField.text ?? "") {[weak self] result in
//            if result == true {
//                self?.signUpView.emailCheckButton.backgroundColor = .systemGreen
//                self?.validEmail = true
//            } else {
//                self?.signUpView.emailCheckButton.backgroundColor = .systemGray
//                self?.validEmail = false
//            }
//        }
//    }
    
    @objc func pressFinishButton() {
        if validEmail == true {
            let email = signUpView.emailTextField.text ?? ""
            let password = signUpView.passwordTextField.text ?? ""
//            let nickName = signUpView.nickNameTextField.text ?? ""
            Auth.auth().createUser(withEmail: email, password: password)
//            firebaseManager.uploadDataToFirestore(email, nickName)
            dismiss(animated: true)
        } else {
            print("gray")
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
}

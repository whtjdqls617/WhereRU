//
//  SignInViewController.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/08.
//

import UIKit
import FirebaseAuth
import KakaoSDKUser

class SignInViewController: BaseViewController {

    let signInView = SignInView()
    
    override func loadView() {
        super.loadView()
        self.view = signInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signInView.signInButton.addTarget(self, action: #selector(pressSignInButton), for: .touchUpInside)
        
        signInView.signUpButton.addTarget(self, action: #selector(pressSignUpButton), for: .touchUpInside)
        
        signInView.kakaoSignInButton.addTarget(self, action: #selector(pressKakaoSignInButton), for: .touchUpInside)
    }
    
    @objc func pressSignInButton() {
        let email = signInView.eamilTextField.text ?? ""
        let password = signInView.passwordTextField.text ?? ""
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if result != nil {
                let mainVC = TabBarViewController()
                mainVC.modalPresentationStyle = .fullScreen
                self.present(mainVC, animated: true)
            } else {
                let alert = UIAlertController(title: "Error", message: "Email과 Password를 다시 한번 확인해 주시길 바랍니다.", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "확인", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: false, completion: nil)
            }
            
        }
    }
    
    @objc func pressKakaoSignInButton() {
//        if (UserApi.isKakaoTalkLoginAvailable()) {
//            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
//                if let error = error {
//                    print(error)
//                }
//                else {
//                    print("loginWithKakaoTalk() success.")
//
//                    //do something
//                    _ = oauthToken
//                    let accessToken = oauthToken?.accessToken
//                    print(accessToken)
//                }
//            }
//        }
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
           if let error = error {
             print(error)
           }
           else {
            print("loginWithKakaoAccount() success.")
            let mainVC = TabBarViewController()
            mainVC.modalPresentationStyle = .fullScreen
            self.present(mainVC, animated: true)
            
            //do something
            _ = oauthToken
           }
        }
    }
    
    @objc func pressSignUpButton() {
        let signUpVC = SignUpViewController()
        signUpVC.modalPresentationStyle = .fullScreen
        present(signUpVC, animated: true)
    }
}

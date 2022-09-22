//
//  EtcViewController.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/22.
//

import UIKit
import KakaoSDKUser

class EtcViewController: BaseViewController {

    let etcView = EtcView()
    
    override func loadView() {
        super.loadView()
        self.view = etcView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapLogout = UITapGestureRecognizer(target: self, action: #selector(pressLogoutButton))
        etcView.logoutButton.isUserInteractionEnabled = true
        etcView.logoutButton.addGestureRecognizer(tapLogout)
    }
    
    @objc func pressLogoutButton() {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
//                let signInViewController = SignInViewController()
                
            }
        }
    }
}

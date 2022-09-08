//
//  SignUpViewController.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/08.
//

import UIKit

class SignUpViewController: BaseViewController {
    
    let signUpView = SignUpView()
    
    override func loadView() {
        super.loadView()
        self.view = signUpView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

//
//  SignInViewController.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/08.
//

import UIKit

class SignInViewController: BaseViewController {

    let signInView = SignInView()
    
    override func loadView() {
        super.loadView()
        self.view = signInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

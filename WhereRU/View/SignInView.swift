//
//  SignInView.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/08.
//

import UIKit

class SignInView: UIView {

    let eamilTextField : UITextField = {
       let textfield = UITextField()
        textfield.placeholder = "이메일을 입력해주세요."
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let passwordTextField : UITextField = {
       let textfield = UITextField()
        textfield.placeholder = "비밀번호를 입력해주세요."
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let signInButton : UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let signUpButton : UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(eamilTextField)
        self.addSubview(passwordTextField)
        self.addSubview(signInButton)
        self.addSubview(signUpButton)
    }
    
    // MARK: AutoLayout
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            eamilTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            eamilTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            
            passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: eamilTextField.bottomAnchor, constant: 40),
            
            signInButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            
            signUpButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 40)
        ])
    }

}

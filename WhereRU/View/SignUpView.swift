//
//  SignUpView.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/08.
//

import UIKit

class SignUpView: UIView {
    
    let appLabel : UILabel = {
        let label = UILabel()
        label.text = "오디야"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let emailTextField : UITextField = {
       let textfield = UITextField()
        textfield.placeholder = "이메일을 입력해주세요."
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let emailCheckButton : UIButton = {
        let button = UIButton()
        button.setTitle("중복 확인", for: .normal)
        button.backgroundColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let emailStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let nickNameTextField : UITextField = {
       let textfield = UITextField()
        textfield.placeholder = "닉네임을 입력해주세요."
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let nickNameCheckButton : UIButton = {
        let button = UIButton()
        button.setTitle("중복 확인", for: .normal)
        button.backgroundColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nickNameStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let passwordTextField : UITextField = {
       let textfield = UITextField()
        textfield.placeholder = "비밀번호를 입력해주세요."
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let finishButton : UIButton = {
        let button = UIButton()
        button.setTitle("가입하기", for: .normal)
        button.backgroundColor = .systemBlue
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
        [emailTextField, emailCheckButton].forEach {
            emailStackView.addArrangedSubview($0)
        }
        
        [nickNameTextField, nickNameCheckButton].forEach {
            nickNameStackView.addArrangedSubview($0)
        }
        
        self.addSubview(appLabel)
        self.addSubview(emailStackView)
        self.addSubview(nickNameStackView)
        self.addSubview(passwordTextField)
        self.addSubview(finishButton)
    }
    
    // MARK: AutoLayout
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            appLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            appLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
            
            emailStackView.topAnchor.constraint(equalTo: appLabel.bottomAnchor, constant: 50),
            emailStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            nickNameStackView.topAnchor.constraint(equalTo: emailStackView.bottomAnchor, constant: 30),
            nickNameStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: nickNameStackView.bottomAnchor, constant: 30),
            passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            finishButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            finishButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

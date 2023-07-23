//
//  RegistrationViewController.swift
//  InstagramApp
//
//  Created by Vadim Kononenko on 22.07.2023.
//

import UIKit
import SnapKit

class RegistrationViewController: UIViewController {

    // MARK: - Properties
    
    private lazy var plusPhotoBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "plus_photo"), for: .normal)
        btn.tintColor = .white
        return btn
    }()
    
    private let emailTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Email")
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let fullnameTextField = CustomTextField(placeholder: "Fullname")
    private let usernameTextField = CustomTextField(placeholder: "Username")
    
    private lazy var signInBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign In", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        return btn
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 20
        return stack
    }()
    
    private lazy var alreadyHaveAccountBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.attributedTitle(firstPart: "Already have an account?", secondPart: "Sign In")
        btn.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    // MARK: - Actions
    
    @objc private func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }

}

// MARK: - Configure

extension RegistrationViewController {
    
    private func configure() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        configureGradientLayer()
        
        view.addSubview(plusPhotoBtn)
        
        view.addSubview(stack)
        stack.addArrangedSubview(emailTextField)
        stack.addArrangedSubview(passwordTextField)
        stack.addArrangedSubview(fullnameTextField)
        stack.addArrangedSubview(usernameTextField)
        stack.addArrangedSubview(signInBtn)
        
        view.addSubview(alreadyHaveAccountBtn)
    }
    
    private func setupConstraints() {
        plusPhotoBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            make.height.width.equalTo(140)
            make.centerX.equalToSuperview()
        }
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(plusPhotoBtn.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        
        fullnameTextField.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        
        signInBtn.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        
        alreadyHaveAccountBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
}

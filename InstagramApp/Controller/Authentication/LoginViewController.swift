//
//  LoginViewController.swift
//  InstagramApp
//
//  Created by Vadim Kononenko on 22.07.2023.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = LoginViewModel()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Instagram_logo_white")
        iv.contentMode = .scaleAspectFill
        return iv
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
    
    private lazy var loginBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Log In", for: .normal)
        btn.setTitleColor(UIColor(white: 1, alpha: 0.67), for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.isEnabled = false
        return btn
    }()
    
    private let tfStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 20
        return stack
    }()
    
    private lazy var forgotPasswordBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.attributedTitle(firstPart: "Forgot your password?", secondPart: "Get help signing in.")
        return btn
    }()
    
    private lazy var dontHaveAccountBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.attributedTitle(firstPart: "Don't have an account?", secondPart: "Sign Up")
        btn.addTarget(self, action: #selector(handleShowSignIn), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        configureNotificationObservers()
    }
    
    // MARK: - Actions
    
    @objc private func handleShowSignIn() {
        let controller = RegistrationViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func textDidChanged(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        
        updateForm()
    }
    
    // MARK: - Helpers

    private func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
    }
    
}

// MARK: - Configure

extension LoginViewController {
    
    private func configure() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        configureGradientLayer()
        
        view.addSubview(iconImageView)
        
        tfStackView.addArrangedSubview(emailTextField)
        tfStackView.addArrangedSubview(passwordTextField)
        tfStackView.addArrangedSubview(loginBtn)
        tfStackView.addArrangedSubview(forgotPasswordBtn)
        view.addSubview(tfStackView)
        
        view.addSubview(dontHaveAccountBtn)
    }
    
    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            make.height.equalTo(80)
            make.width.equalTo(120)
            make.centerX.equalToSuperview()
        }
        
        tfStackView.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        
        loginBtn.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        
        dontHaveAccountBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
}

// MARK: - FormViewModel

extension LoginViewController: FormViewModel {
    func updateForm() {
        UIView.animate(withDuration: 0.2) {
            self.loginBtn.backgroundColor = self.viewModel.buttonBackgroundColor
            self.loginBtn.setTitleColor(self.viewModel.buttonTitleColor, for: .normal)
            self.loginBtn.isEnabled = self.viewModel.formIsValid
        }
    }
}

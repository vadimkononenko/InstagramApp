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
    
    private var viewModel = RegistrationViewModel()
    private var profileImage: UIImage?
    weak var delegate: AuthenticationDelegate?
    
    private lazy var plusPhotoBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "plus_photo"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(handleProfilePhotoSelect), for: .touchUpInside)
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
        btn.setTitleColor(UIColor(white: 1, alpha: 0.67), for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
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
        configureNotificationObservers()
    }
    
    // MARK: - Actions
    
    @objc private func handleSignUp() {
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text,
            let fullname = fullnameTextField.text,
            let username = usernameTextField.text,
            let profileImage = profileImage
        else { return }
        
        let credentials = AuthCredentials(email: email,
                                          password: password,
                                          fullname: fullname,
                                          username: username,
                                          profileImage: profileImage)
        
        AuthService.registerUser(withCredentials: credentials) { error in
            if let error = error {
                print("DEBUG: Failed to register user \(error.localizedDescription)")
                return
            }
            
            self.delegate?.authenticationDidComplete()
        }
    }
    
    @objc private func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func textDidChanged(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        } else if sender == fullnameTextField {
            viewModel.fullname = sender.text
        } else {
            viewModel.username = sender.text
        }
        
        updateForm()
    }
    
    @objc private func handleProfilePhotoSelect() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true)
    }
    
    // MARK: - Helpers

    private func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
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

// MARK: - FormViewModel

extension RegistrationViewController: FormViewModel {
    func updateForm() {
        UIView.animate(withDuration: 0.2) {
            self.signInBtn.backgroundColor = self.viewModel.buttonBackgroundColor
            self.signInBtn.setTitleColor(self.viewModel.buttonTitleColor, for: .normal)
            self.signInBtn.isEnabled = self.viewModel.formIsValid
        }
    }
}

// MARK: - UIImagePickerControllerDelegate

extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        profileImage = selectedImage
        
        plusPhotoBtn.layer.cornerRadius = plusPhotoBtn.frame.width / 2
        plusPhotoBtn.layer.masksToBounds = true
        plusPhotoBtn.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true)
    }
    
}

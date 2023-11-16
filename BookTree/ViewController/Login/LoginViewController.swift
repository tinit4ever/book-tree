//
//  LoginViewController.swift
//  BookTree
//
//  Created by Nguyen Trung Tin on 16/11/2023.
//

import UIKit
import SwiftUI
//import FirebaseAuth

class LoginViewController: UIViewController {
    var viewModel: LoginViewModelProtocol?
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var mailTextField: UITextField = {
        let textField = UITextField()
        
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray
        ]
        let attributedPlaceholder = NSAttributedString(string: "Email", attributes: placeholderAttributes)
        
        textField.attributedPlaceholder = attributedPlaceholder
        
        
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.isSecureTextEntry = true
        
        let showPasswordButton = UIButton(type: .custom)
        showPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
        showPasswordButton.tintColor = .gray
        showPasswordButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        textField.rightView = showPasswordButton
        textField.rightViewMode = .always
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray
        ]
        let attributedPlaceholder = NSAttributedString(string: "Password", attributes: placeholderAttributes)
        
        textField.attributedPlaceholder = attributedPlaceholder
        
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        
        var configuration = UIButton.Configuration.gray()
        configuration.title = "Login"
        configuration.baseBackgroundColor = .white
        
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .red
        label.text = "ERROR"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        errorLabel.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        errorLabel.isHidden = true
    }
    
    // SetupUI
    func setupUI() {
        view.addSubview(backgroundImage)
        
        let gifImage = UIImage.gifImageWithName("book")
        backgroundImage.image = gifImage
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        stackView.addArrangedSubview(mailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(errorLabel)
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            mailTextField.heightAnchor.constraint(equalTo: loginButton.heightAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: loginButton.heightAnchor)
        ])
        
    }
    
    // Setup Action
    func setupAction() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    func setViewModel(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    // Catch Action
    @objc
    func loginButtonTapped() {
        guard let mail = mailTextField.text,
              let password = passwordTextField.text else {
            return
        }
        
        viewModel?.login(mail, password) { errorString in
            if let errorString = errorString {
                DispatchQueue.main.async { [self] in
                    errorLabel.isHidden = false
                    errorLabel.text = errorString
                }
            } else {
                UserDefaults.standard.set(true, forKey: UserDefaultKeys.isLoggedIn)
                let mainViewController = MainTabBarViewController()
                DispatchQueue.main.async {
                    //                    self.navigationController?.setViewControllers([mainViewController], animated: true)
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        let window = windowScene.windows.first
                        window?.rootViewController = mainViewController
                        window?.makeKeyAndVisible()
                    }

                }
            }
        }
    }
    
    @objc
    private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        let eyeSymbol = passwordTextField.isSecureTextEntry ? "eye" : "eye.slash"
        if let showPasswordButton = passwordTextField.rightView as? UIButton {
            showPasswordButton.setImage(UIImage(systemName: eyeSymbol), for: .normal)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
}


// -MARK: Preview
struct LoginViewControllerPreview: PreviewProvider {
    static var previews: some View {
        VCPreview {
            let loginViewController = LoginViewController()
            return loginViewController
        }
    }
}


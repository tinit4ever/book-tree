//
//  LoginViewController.swift
//  BookTree
//
//  Created by Nguyen Trung Tin on 16/11/2023.
//

import UIKit
import SwiftUI
import Combine
import LocalAuthentication

class LoginViewController: UIViewController {
    
    var viewModel: LoginViewModelProtocol?
    
    var cancellables: Set<AnyCancellable> = []
    
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
    
    private lazy var loginStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
    
    private lazy var biometricLoginButton = {
        let button = UIButton()
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
        setupUI()
        setupAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        errorLabel.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        errorLabel.isHidden = true
    }
    
    // SetupUI
    func setupUI() {
        view.backgroundColor = .systemBackground
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
        
        stackView.addArrangedSubview(loginStack)
        configureLoginStack()
        
        //        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(errorLabel)
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            loginStack.heightAnchor.constraint(equalToConstant: 40),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            biometricLoginButton.widthAnchor.constraint(equalToConstant: 40),
            mailTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureLoginStack() {
        var configuration = UIButton.Configuration.gray()
        
        let authContext = LAContext()
        var error: NSError?
        
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            if authContext.biometryType == .touchID {
                configuration.image = UIImage(systemName: "touchid")
            } else if authContext.biometryType == .faceID {
                configuration.image = UIImage(systemName: "faceid")
            }
        }
        biometricLoginButton.configuration = configuration
        
        loginStack.addArrangedSubview(loginButton)
        loginStack.addArrangedSubview(biometricLoginButton)
    }
    
    // Setup Action
    func setupAction() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        biometricLoginButton.addTarget(self, action: #selector(biometricLoginButtonTapped), for: .touchUpInside)
    }
    
    func setViewModel(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    @objc
    func biometricLoginButtonTapped() {
        let context = LAContext()
        var error: NSError? = nil
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authorize with touch ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
                guard success, error == nil else {
                    let alert = UIAlertController(title: "Fail to authenticate", message: "Please try again.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self?.present(alert, animated: true)
                    return
                }
                
                DispatchQueue.main.async {
                    UserDefaults.standard.set(true, forKey: UserDefaultKeys.isLoggedIn)
                    let mainViewController = MainTabBarViewController()
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        let window = windowScene.windows.first
                        window?.rootViewController = mainViewController
                        window?.makeKeyAndVisible()
                    }
                }
            }
        } else {
            let alert = UIAlertController(title: "Unavailable", message: "You cant use this feature", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }
    
    @objc
    func loginButtonTapped() {
        guard let mail = mailTextField.text,
              let password = passwordTextField.text else {
            return
        }
        
        viewModel?.login(mail, password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.showError(error.localizedDescription)
                }
            }, receiveValue: { _ in
                UserDefaults.standard.set(true, forKey: UserDefaultKeys.isLoggedIn)
                let mainViewController = MainTabBarViewController()
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    let window = windowScene.windows.first
                    window?.rootViewController = mainViewController
                    window?.makeKeyAndVisible()
                }
            })
            .store(in: &cancellables)
    }
    
    private func showError(_ message: String) {
        errorLabel.isHidden = false
        errorLabel.text = message
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


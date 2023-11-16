//
//  SignUpViewController.swift
//  BookTree
//
//  Created by Nguyen Trung Tin on 16/11/2023.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
   
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let passwordStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray
        ]
        let attributedPlaceholder = NSAttributedString(string: "First Name", attributes: placeholderAttributes)

        textField.attributedPlaceholder = attributedPlaceholder
        
        return textField
    }()
    
    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray
        ]
        let attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: placeholderAttributes)

        textField.attributedPlaceholder = attributedPlaceholder
        
        return textField
    }()
    
    private let mailTextField: UITextField = {
        let textField = UITextField()
        
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray
        ]
        let attributedPlaceholder = NSAttributedString(string: "Mail", attributes: placeholderAttributes)

        textField.attributedPlaceholder = attributedPlaceholder
        
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        
        textField.keyboardType = .default
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray
        ]
        let attributedPlaceholder = NSAttributedString(string: "Password", attributes: placeholderAttributes)

        textField.attributedPlaceholder = attributedPlaceholder
        
        return textField
    }()
    
    private let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        
        textField.keyboardType = .default
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray
        ]
        let attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: placeholderAttributes)

        textField.attributedPlaceholder = attributedPlaceholder
        
        return textField
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Sign Up"
        configuration.baseBackgroundColor = .systemRed
        
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let notificationLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .red
        label.text = "ERROR"
        label.textAlignment = .center
        label.font.withSize(10)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordErrorLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .red
        label.text = "ERROR"
        label.font = UIFont.systemFont(ofSize: 14)
        
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
        passwordErrorLabel.isHidden = true
        notificationLabel.isHidden = true
    }
    
    // Setup UI
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
        
        passwordStackView.addArrangedSubview(passwordTextField)
        passwordStackView.addArrangedSubview(passwordErrorLabel)
        stackView.addArrangedSubview(mailTextField)
        stackView.addArrangedSubview(passwordStackView)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(signUpButton)
        stackView.addArrangedSubview(notificationLabel)
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        mailTextField.delegate = self
        passwordTextField.delegate = self
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
            mailTextField.heightAnchor.constraint(equalTo: signUpButton.heightAnchor),
            passwordStackView.heightAnchor.constraint(equalTo: signUpButton.heightAnchor, multiplier: 1.3),
            confirmPasswordTextField.heightAnchor.constraint(equalTo: signUpButton.heightAnchor),
            signUpButton.heightAnchor.constraint(equalTo: signUpButton.heightAnchor)
        ])
        
    }
    
    // Setup Action
    func setupAction() {
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    // Catch Action
    
    @objc
    func signUpButtonTapped() {
        if let mail = mailTextField.text,
           let password = passwordTextField.text,
           passwordTextField.text == confirmPasswordTextField.text
        {
            Auth.auth().createUser(withEmail: mail, password: password) { [self] authResult, error in
                if let error = error {
                    print(error.localizedDescription)
                    notificationLabel.isHidden = false
                    notificationLabel.textColor = .red
                    notificationLabel.text = error.localizedDescription
                } else {
                    print(authResult?.user.uid ?? "No user ID")
                    authResult?.user.sendEmailVerification { [self] error in
                        if let error = error {
                            notificationLabel.isHidden = false
                            notificationLabel.textColor = .green
                            notificationLabel.text = error.localizedDescription
                        } else {
                            notificationLabel.isHidden = false
                            notificationLabel.textColor = .green
                            notificationLabel.text = "Email verification sent, please confirm in your mail and try to login"
                        }
                    }
                }
            }
        } else {
            notificationLabel.isHidden = false
            notificationLabel.textColor = .red
            notificationLabel.text = "Password is not match with your confirm"
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField === passwordTextField {
            passwordErrorLabel.isHidden = true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard let text = textField.text else {
            return
        }
        
        if textField === passwordTextField && text.count < 6 {
            passwordErrorLabel.text = "Password least contains 6 letters"
            passwordErrorLabel.isHidden = false
        }
    }
}

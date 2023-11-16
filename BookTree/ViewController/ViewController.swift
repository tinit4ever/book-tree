//
//  ViewController.swift
//  BookTree
//
//  Created by Nguyen Trung Tin on 16/11/2023.
//
//
//  ViewController.swift
//  The Movie
//
//  Created by tinit on 04/11/2023.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
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
    
    private let loginButton: UIButton = {
        let button = UIButton()
        
        var configuration = UIButton.Configuration.gray()
        configuration.title = "Login"
        configuration.baseBackgroundColor = .white
        
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupAction()
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
        
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(signUpButton)
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            signUpButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor)
        ])
    }
    
    // Setup Action
    func setupAction() {
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    // Catch Action
    @objc
    func signUpButtonTapped() {
        let signUpViewController = SignUpViewController()
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    @objc
    func loginButtonTapped() {
        let loginViewController = LoginViewController()
        loginViewController.setViewModel(viewModel: LoginViewModel())
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
}

// -MARK: Preview
struct RootViewControllerPreview: PreviewProvider {
    static var previews: some View {
        VCPreview {
            let viewController = ViewController()
            return viewController
        }
    }
}


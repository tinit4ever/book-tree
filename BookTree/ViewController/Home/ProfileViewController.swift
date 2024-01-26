//
//  ProfileViewController.swift
//  BookTree
//
//  Created by Nguyen Trung Tin on 17/11/2023.
//

import UIKit
import SwiftUI
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var uidStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var titleUIDLabel: UILabel = {
        let label = UILabel()
        label.text = "User ID"
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var contentUIDLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Chalkboard SE", size: 20)
        label.text = "N/A"
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var displayNameStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var titleDisplayNameLabel: UILabel = {
        let label = UILabel()
        label.text = "User Name"
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var contentDisplayNameLabel: UILabel = {
        let label = UILabel()
        label.text = "N/A"
        label.font = UIFont(name: "Chalkboard SE", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var titleEmailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var titleEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var verifiedLabel: UILabel = {
        let label = UILabel()
        label.text = "Not Verified"
        label.font = UIFont(name: "Chalkboard SE", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var verifiedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "exclamationmark.circle.fill")
        imageView.tintColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var contentEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "N/A"
        label.font = UIFont(name: "Chalkboard SE", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - UI
    func setupUI() {
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        
        view.addSubview(imageView)
        imageViewConfigure()
        
        view.addSubview(scrollView)
        scrollViewConfig()
    }
    
    func setupNavigationBar() {
        title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped))
    }
    
    func imageViewConfigure() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func scrollViewConfig() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 60),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        scrollView.addSubview(stackView)
        stackViewConfigure()
    }
    
    func stackViewConfigure() {
        stackView.addArrangedSubview(uidStackView)
        uidStackView.addArrangedSubview(titleUIDLabel)
        uidStackView.addArrangedSubview(contentUIDLabel)
        
        stackView.addArrangedSubview(displayNameStackView)
        displayNameStackView.addArrangedSubview(titleDisplayNameLabel)
        displayNameStackView.addArrangedSubview(contentDisplayNameLabel)
        
        stackView.addArrangedSubview(emailStackView)
        
        emailStackView.addArrangedSubview(titleEmailStackView)
        
        titleEmailStackView.addArrangedSubview(titleEmailLabel)
        titleEmailStackView.addArrangedSubview(verifiedLabel)
        titleEmailStackView.addArrangedSubview(verifiedImage)
        
        emailStackView.addArrangedSubview(contentEmailLabel)
        
        stackView.addArrangedSubview(logoutButton)
        logoutButtonConfigure()
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        ])
    }
    
    func logoutButtonConfigure() {
        var configuration = UIButton.Configuration.tinted()
        configuration.title = "Logout"
        logoutButton.configuration = configuration
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Data
    func setupData() {
        if let user = Auth.auth().currentUser {
            //            let photoURL = user.photoURL
            contentUIDLabel.text = user.uid
            contentEmailLabel.text = user.email
            contentDisplayNameLabel.text = user.displayName
            
            if user.isEmailVerified {
                verifiedLabel.text = "verified"
                verifiedImage.image = UIImage(systemName: "checkmark.circle.fill")
                verifiedImage.tintColor = .green
            } else {
                verifiedLabel.text = "not verified"
                verifiedImage.image = UIImage(systemName: "exclamationmark.circle.fill")
                verifiedImage.tintColor = .red
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.makeRounded()
    }
    
    // MARK: - Action
    
    @objc
    func logoutButtonTapped() {
        let viewController = ViewController()
        UserDefaults().set(false, forKey: UserDefaultKeys.isLoggedIn)
        UserDefaults.standard.removeObject(forKey: UserDefaultKeys.isLoggedIn)
        DispatchQueue.main.async {
            self.navigationController?.setViewControllers([viewController], animated: true)
        }
    }
    
    @objc
    func editButtonTapped() {
        let profileEditViewController = ProfileEditViewController()
        navigationController?.pushViewController(profileEditViewController, animated: true)
    }
}

// -MARK: Preview
struct ProfileViewControllerPreview: PreviewProvider {
    static var previews: some View {
        VCPreview {
            let profileViewController = UINavigationController(rootViewController: ProfileViewController())
            return profileViewController
        }
    }
}

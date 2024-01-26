//
//  ProffileEditViewController.swift
//  BookTree
//
//  Created by Nguyen Trung Tin on 17/11/2023.
//

import UIKit
import SwiftUI
import FirebaseAuth

class ProfileEditViewController: UIViewController {
    
    var onDoneButtonTapped: (() -> Void)?
    
    // Init UI
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.distribution = .equalSpacing
        stackView.contentMode = .scaleAspectFill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var displayNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Chalkboard SE", size: 22)
        textField.borderStyle = .roundedRect
        textField.contentMode = .scaleToFill
        textField.autocapitalizationType = .words
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var emailStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var titleEmailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Chalkboard SE", size: 22)
        textField.borderStyle = .roundedRect
        textField.contentMode = .scaleToFill
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var oldPasswordStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var titleOldPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var oldPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Chalkboard SE", size: 22)
        textField.borderStyle = .roundedRect
        textField.contentMode = .scaleToFill
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var newPasswordStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var titleNewPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var newPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Chalkboard SE", size: 22)
        textField.borderStyle = .roundedRect
        textField.contentMode = .scaleToFill
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    // MARK: - UI
    func setupUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        
        view.addSubview(imageView)
        imageViewConfigure()
        
        view.addSubview(stackView)
        stackViewConfigure()
    }
    
    func configureNavigationBar() {
        title = "Edit Profile"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
    }
    
    func imageViewConfigure() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func stackViewConfigure() {
        stackView.addArrangedSubview(displayNameStackView)
        displayNameStackView.addArrangedSubview(titleDisplayNameLabel)
        displayNameStackView.addArrangedSubview(displayNameTextField)
        
        stackView.addArrangedSubview(emailStackView)
        emailStackView.addArrangedSubview(titleEmailLabel)
        emailStackView.addArrangedSubview(emailTextField)
        
        stackView.addArrangedSubview(oldPasswordStackView)
        oldPasswordStackView.addArrangedSubview(titleOldPasswordLabel)
        oldPasswordStackView.addArrangedSubview(oldPasswordTextField)
        
        stackView.addArrangedSubview(newPasswordStackView)
        newPasswordStackView.addArrangedSubview(titleNewPasswordLabel)
        newPasswordStackView.addArrangedSubview(newPasswordTextField)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        ])
    }
    
    // MARK: - Data
    func setupData() {
        let currentUser = Auth.auth().currentUser
        imageView.image = UIImage(systemName: "person.fill")
        titleDisplayNameLabel.text = "Username"
        displayNameTextField.placeholder = "Username"
        displayNameTextField.text = currentUser?.displayName ?? ""
        
        titleEmailLabel.text = "Email"
        emailTextField.placeholder = "Email"
        emailTextField.text = currentUser?.email ?? ""
        
        titleOldPasswordLabel.text = "Old Password"
        oldPasswordTextField.placeholder = "Old Password"
        
        titleNewPasswordLabel.text = "New Password"
        newPasswordTextField.placeholder = "New Password"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.makeRounded()
    }
    
    // MARK: - Action
    @objc
    func doneButtonTapped() {
        guard
            let user = Auth.auth().currentUser,
            let newDisplayName = displayNameTextField.text, !newDisplayName.isEmpty,
            let newEmail = emailTextField.text, !newEmail.isEmpty,
            let oldPassword = oldPasswordTextField.text, !oldPassword.isEmpty,
            let newPassword = newPasswordTextField.text, !newPassword.isEmpty
        else {
            showErrorMessage(message: "Invalid input. Please fill in all fields.")
            return
        }
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        reauthenticateUser(user: user, password: oldPassword) { success in
            if !success {
                self.showErrorMessage(message: "Reauthentication failed. Please check your old password.")
                return
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        updateEmail(user: user, newEmail: newEmail) { success in
            if !success {
                self.showErrorMessage(message: "Failed to update email. Please try again.")
                return
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        updateDisplayName(user: user, newDisplayName: newDisplayName) { success in
            if !success {
                self.showErrorMessage(message: "Failed to update display name. Please try again.")
                return
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        updatePassword(user: user, newPassword: newPassword) { success in
            if !success {
                self.showErrorMessage(message: "Failed to update password. Please try again.")
                return
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            print("All updates completed successfully")
        }
    }
    
    func reauthenticateUser(user: User, password: String, completion: @escaping (Bool) -> Void) {
        let credential = EmailAuthProvider.credential(withEmail: user.email ?? "", password: password)
        user.reauthenticate(with: credential) { _, error in
            if let error = error {
                print("Error reauthenticating user: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func updateEmail(user: User, newEmail: String, completion: @escaping (Bool) -> Void) {
        user.updateEmail(to: newEmail) { error in
            if let error = error {
                print("Error updating email: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func updateDisplayName(user: User, newDisplayName: String, completion: @escaping (Bool) -> Void) {
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = newDisplayName
        changeRequest.commitChanges { error in
            if let error = error {
                print("Error updating display name: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func updatePassword(user: User, newPassword: String, completion: @escaping (Bool) -> Void) {
        user.updatePassword(to: newPassword) { error in
            if let error = error {
                print("Error updating password: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func showErrorMessage(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func showSuccessMessage(message: String) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension ProfileEditViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.text = ""
    }
}

// -MARK: Preview
struct ProfileEditViewControllerPreview: PreviewProvider {
    static var previews: some View {
        VCPreview {
            let profileViewController = UINavigationController(rootViewController: ProfileEditViewController())
            return profileViewController
        }
    }
}

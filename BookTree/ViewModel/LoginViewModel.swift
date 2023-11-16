//
//  LoginViewModel.swift
//  BookTree
//
//  Created by Nguyen Trung Tin on 16/11/2023.
//

import Foundation
import FirebaseAuth

protocol LoginViewModelProtocol {
    func login(_ mail: String,_ password: String, completion: @escaping (String?) -> Void)
}

class LoginViewModel { }

extension LoginViewModel: LoginViewModelProtocol {
    func login(_ mail: String,_ password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: mail, password: password) { result, error in
            if let error = error {
                completion(error.localizedDescription)
            } else {
                completion(nil)
            }
        }
    }
}

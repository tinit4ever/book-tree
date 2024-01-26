//
//  LoginViewModel.swift
//  BookTree
//
//  Created by Nguyen Trung Tin on 16/11/2023.
//

import Foundation
import FirebaseAuth
import Combine

protocol LoginViewModelProtocol {
//    func login(_ mail: String,_ password: String, completion: @escaping (String?) -> Void)
    func login(_ mail: String, _ password: String) -> AnyPublisher<Void, Error>
}

class LoginViewModel { }

extension LoginViewModel: LoginViewModelProtocol {
    func login(_ mail: String, _ password: String) -> AnyPublisher<Void, Error> {
        return Future { promise in
            Auth.auth().signIn(withEmail: mail, password: password) { result, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
//    func login(_ mail: String,_ password: String, completion: @escaping (String?) -> Void) {
//        Auth.auth().signIn(withEmail: mail, password: password) { result, error in
//            if let error = error {
//                completion(error.localizedDescription)
//            } else {
//                completion(nil)
//            }
//        }
//    }
}

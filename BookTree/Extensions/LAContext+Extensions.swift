////
////  File.swift
////  BookTree
////
////  Created by Nguyen Trung Tin on 20/11/2023.
////
//
////import Foundation
//import LocalAuthentication
//
//extension LAContext {
//    enum BiometricType: String {
//        case none
//        case touchID
//        case faceID
//    }
//
//    var biometricType: BiometricType {
//        var error: NSError?
//
//        guard self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
//            return .none
//        }
//
//        if #available(iOS 11.0, *) {
//            switch self.biometryType {
//            case .none:
//                return .none
//            case .touchID:
//                return .touchID
//            case .faceID:
//                return .faceID
//            case .opticID:
//                return .none
//            @unknown default:
//                return .none
//            }
//        } else {
//            return  self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touchID : .none
//        }
//    }
//}

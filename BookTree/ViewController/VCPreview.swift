//
//  File.swift
//  BookTree
//
//  Created by Nguyen Trung Tin on 13/11/2023.
//

import SwiftUI
struct VCPreview<T: UIViewController>: UIViewControllerRepresentable {
    
    let viewController: T
    
    init(_ viewControllerBuilder: @escaping () -> T) {
        viewController = viewControllerBuilder()
    }
    
    func makeUIViewController(context: Context) -> T {
        viewController
    }
    
    func updateUIViewController(_ uiViewController: T, context: Context) { }
}

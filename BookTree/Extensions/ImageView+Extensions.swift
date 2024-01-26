//
//  ImageView+Extensions.swift
//  BookTree
//
//  Created by Nguyen Trung Tin on 17/11/2023.
//

import UIKit

extension UIImageView {
    
    func makeRounded() {
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.black.cgColor
        let radius = CGRectGetWidth(self.frame) / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
}

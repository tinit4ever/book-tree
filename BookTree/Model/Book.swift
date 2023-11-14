//
//  Book.swift
//  BookTree
//
//  Created by Nguyen Trung Tin on 14/11/2023.
//

import Foundation

struct BookAPIResponse: Decodable {
    let items: [BookAPI]
}

struct BookAPI: Decodable {
    let kind: String
    let selfLink: String
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Decodable {
    let title: String
    let description: String
}
